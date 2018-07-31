//
//  MovieViewController.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 21/07/18.
//

import SDWebImage
import UIKit

class MovieViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var averageRating: UILabel!
    @IBOutlet weak var relaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupMovie()
    }

    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func setupMovie() {
        if let posterPath = movie?.posterPath {
            let posterURL = Constants.API_URL_IMAGE + posterPath
            posterImageView.sd_setImage(with: URL(string: posterURL), placeholderImage: #imageLiteral(resourceName: "movie-placeholder-portrait"))
        }

        if let backdropPath = movie?.backdropPath {
            let backgroundURL = Constants.API_URL_IMAGE + backdropPath
            backgroundImageView.sd_setImage(with: URL(string: backgroundURL), placeholderImage: #imageLiteral(resourceName: "movie-placeholder-landscape"))
        }
        
        movieTitleLabel.text = movie?.title ?? ""
        averageRating.text = String(movie?.voteAverage ?? 0) + " / 10"
        relaseDateLabel.text = movie?.releaseDate ?? ""
        overviewLabel.text = movie?.overview
    }

    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
