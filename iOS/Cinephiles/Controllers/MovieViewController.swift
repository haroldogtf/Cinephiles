//
//  MovieViewController.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 21/07/18.
//

import UIKit

class MovieViewController: UIViewController {

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = movie?.title
    }

}
