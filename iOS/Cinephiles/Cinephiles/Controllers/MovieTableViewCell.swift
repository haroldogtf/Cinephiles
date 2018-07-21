//
//  MovieTableViewCell.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

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
        //moviePosterImageView.image =
        movieTitleLabel.text = movie.title
    }

}
