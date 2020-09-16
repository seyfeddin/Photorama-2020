//
//  PhotoInfoViewController.swift
//  Photorama-2020
//
//  Created by Seyfeddin Bassarac on 23.05.2020.
//  Copyright © 2020 Medipol. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!

    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!

    override func viewDidLoad() {

        super.viewDidLoad()

        store.fetchImage(for: photo) { (result) in

            switch result {
            case let .success(image):
                self.imageView.image = image
            case .failure:
                print("Error fetching image for: \(self.photo)")
            }
        }
    }
}
