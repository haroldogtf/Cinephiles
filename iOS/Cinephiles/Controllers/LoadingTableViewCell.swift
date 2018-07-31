//
//  LoadingTableViewCell.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 21/07/18.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
