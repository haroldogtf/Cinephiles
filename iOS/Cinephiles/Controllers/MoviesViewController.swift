//
//  MoviesViewController.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var movies:[Movie] = []
    var fetchingData = false
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        loadData()
    }

    func setupTableView() {
        let loadingNib = UINib(nibName: Constants.IDENTIFIER_LOADING_TABLEVIEWCELL, bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: Constants.IDENTIFIER_LOADING_TABLEVIEWCELL)
    }

    func loadData() {
        MoviesAPIManager.getPopupar(page: page) { (movies, error) in
            self.fetchingData = false
            self.page += 1
            self.movies += movies
            self.tableView.reloadData()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingData {
                fetchData()
            }
        }
    }

    func fetchData() {
        fetchingData = true
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        loadData()
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
        if section == 0 {
            return movies.count
        } else if section == 1 && fetchingData {
            return 1
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.IDENTIFIER_MOVIE_TABLEVIEWCELL) as! MovieTableViewCell
            cell.fill(movie: movies[indexPath.row])
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
        if indexPath.section == 0 {
            performSegue(withIdentifier: Constants.IDENTIFIER_MOVIE_VIEWCONTROLLER, sender: movies[indexPath.row])
        }
    }
    
}
