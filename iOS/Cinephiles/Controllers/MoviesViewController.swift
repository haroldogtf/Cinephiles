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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    func loadData() {
        MoviesAPIManager.getPopupar(page: 1) { (movies, error) in
            self.movies = movies
            self.tableView.reloadData()
        }
    }

}

extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.IDENTIFIER_MOVIE_TABLEVIEWCELL) as! MovieTableViewCell
        cell.fill(movie: movies[indexPath.row])

        return cell
    }

}

extension MoviesViewController: UITableViewDelegate {
    
}
