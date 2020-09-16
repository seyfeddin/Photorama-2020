//
//  PhotosViewController.swift
//  Photorama-2020
//
//  Created by Seyfeddin Bassarac on 16.05.2020.
//  Copyright © 2020 Medipol. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    var photoStore: PhotoStore!

    let photoDataSource = PhotoDataSource()

    var numberOfItemsInRow: CGFloat {
        if UIScreen.main.bounds.width > 500 {
            return 6
        } else {
            return 4
        }
    }

    private func calculateItemSizes() {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = (collectionView.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - (flowLayout.minimumInteritemSpacing * numberOfItemsInRow - 1)) / numberOfItemsInRow
        if flowLayout.itemSize.width != itemWidth {
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = photoDataSource
        collectionView.delegate = self

        calculateItemSizes()

        photoStore.fetchInterestingPhotos { (result) in

            switch result {
            case .success(let photos):
                print("Successfully found \(photos.count) photos")
                self.photoDataSource.photos = photos
            case .failure(let error):
                print("Error fetching interesting photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()

        calculateItemSizes()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {

        let photo = photoDataSource.photos[indexPath.row]

        photoStore.fetchImage(for: photo) { (result) in

            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else {
                    return
            }

            let photoIndexPath = IndexPath(item: photoIndex, section: 0)

            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showPhoto" {
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {

                let photo = photoDataSource.photos[selectedIndexPath.row]

                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = photoStore
            }
        }
    }
}
