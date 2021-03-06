//
//  PhotoCollectionViewCell.swift
//  Photorama-2020
//
//  Created by Seyfeddin Bassarac on 23.05.2020.
//  Copyright © 2020 Medipol. All rights reserved.
//

import UIKit


class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()

        update(with: nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        update(with: nil)
    }

    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}
