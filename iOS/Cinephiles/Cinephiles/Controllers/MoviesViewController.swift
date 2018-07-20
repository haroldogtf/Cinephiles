//
//  MoviesViewController.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import UIKit

class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }

    func loadData() {
        MoviesAPIManager.getPopupar(page: 1) { (movies, error) in
            
        }
    }

}

