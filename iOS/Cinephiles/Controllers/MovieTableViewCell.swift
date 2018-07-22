//
//  MovieTableViewCell.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import SDWebImage
import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func fill(movie: Movie) {
        if let posterPath = movie.posterPath {
            let posterURL = Constants.API_URL_IMAGE + posterPath
            moviePosterImageView.sd_setImage(with: URL(string: posterURL), placeholderImage: #imageLiteral(resourceName: "movie-placeholder-portrait"))
        }
        movieTitleLabel.text = movie.title
    }

}
