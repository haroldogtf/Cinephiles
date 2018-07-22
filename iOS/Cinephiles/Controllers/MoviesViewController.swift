//
//  MoviesViewController.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import PKHUD
import Reachability
import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var noConnectionView: UIView!
    @IBOutlet var noFilteredMoviesView: UIView!
    @IBOutlet var emptySearchView: UIView!

    let MAIN_SECTION = 0
    let LOADING_SECTION = 1

    var movies:[Movie] = []
    var fetchingData = false
    var page = 1

    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies:[Movie] = []
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearch()
        setupReachability()
        loadData()
    }

    func setupTableView() {
        tableView.keyboardDismissMode = .onDrag

        let loadingNib = UINib(nibName: Constants.IDENTIFIER_LOADING_TABLEVIEWCELL, bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: Constants.IDENTIFIER_LOADING_TABLEVIEWCELL)
    }

    func setupSearch() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }

    func setupReachability() {
        ReachabilityManager.shared.addListener(self)
    }

    func showViewInTableView(view: UIView) {
        tableView.backgroundView = view
        tableView.separatorStyle = .none
    }

    func removeViewFromTableView() {
        tableView.backgroundView = nil
        tableView.separatorStyle = .singleLine
    }

    func loadData() {
        if ReachabilityManager.shared.hasConnection() {
            HUD.show(.progress)
            fetchData()
        } else {
            showViewInTableView(view: noConnectionView)
        }
    }

    func fetchData() {
        MoviesAPIManager.getPopular(page: page) { (movies, error) in
            HUD.hide()

            Util.checkError(self, error: error, f: {
                self.fetchingData = false
                self.page += 1
                self.movies += movies
                self.movies = Array(Set<Movie>(self.movies)) // remove duplicates
                self.movies.sort(by: { $0.popularity ?? 0 > $1.popularity ?? 0 })
                self.tableView.reloadData()
            })
        }
    }



    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingData && !searching {
                fetchMoreData()
            }
        }
    }

    func fetchMoreData() {
        fetchingData = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        fetchData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.IDENTIFIER_MOVIE_VIEWCONTROLLER {
            let movieViewController = segue.destination as! MovieViewController
            movieViewController.movie = sender as? Movie
        }
    }

}

extension MoviesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == MAIN_SECTION {

            if searching {
                if filteredMovies.count == 0 && tableView.backgroundView != emptySearchView {
                   showViewInTableView(view: noFilteredMoviesView)
                }
                return filteredMovies.count
            }

            return movies.count
    
        } else if section == LOADING_SECTION && fetchingData {
            return 1
        }
    
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == MAIN_SECTION {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.IDENTIFIER_MOVIE_TABLEVIEWCELL) as! MovieTableViewCell
            
            var movie: Movie
            if searching {
                movie = filteredMovies[indexPath.row]
            } else {
                 movie = movies[indexPath.row]
            }
            cell.fill(movie: movie)

            return cell
        
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.IDENTIFIER_LOADING_TABLEVIEWCELL) as! LoadingTableViewCell
            cell.spinner.startAnimating()

            return cell
        }
    }

}

extension MoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == MAIN_SECTION {

            var movie:Movie
            if searching {
                movie = filteredMovies[indexPath.row]
            } else {
                movie = movies[indexPath.row]
            }

            performSegue(withIdentifier: Constants.IDENTIFIER_MOVIE_VIEWCONTROLLER, sender: movie)
        }
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = true
        
        HUD.show(.progress)
        MoviesAPIManager.searchBy(string: searchBar.text ?? "") { (movies, error) in
            HUD.hide()

            Util.checkError(self, error: error, f: {
                if movies.count == 0 {
                    self.showViewInTableView(view: self.emptySearchView)

                } else {
                    self.removeViewFromTableView()
                    self.filteredMovies = movies
                    self.filteredMovies.sort(by: { $0.popularity ?? 0 > $1.popularity ?? 0 })
                    
                    self.movies += movies
                    self.movies = Array(Set<Movie>(self.movies)) // remove duplicates
                    self.movies.sort(by: { $0.popularity ?? 0 > $1.popularity ?? 0 })
                }
            
                self.tableView.reloadData()
            })
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        removeViewFromTableView()
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        removeViewFromTableView()

        filteredMovies = movies.filter {
            $0.title?.lowercased().folding(options: .diacriticInsensitive, locale: .current)
                .contains(searchText.lowercased().folding(options: .diacriticInsensitive, locale: .current)) ?? false
        }

        if searchText.count == 0 {
            filteredMovies = movies
        }

        tableView.reloadData()
    }
    
}

extension MoviesViewController: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.Connection) {
        if status != .none && movies.count == 0 {
            removeViewFromTableView()
            loadData()
        }
    }
    
}
