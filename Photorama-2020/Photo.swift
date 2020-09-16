//
//  Photo.swift
//  Photorama-2020
//
//  Created by Seyfeddin Bassarac on 16.05.2020.
//  Copyright © 2020 Medipol. All rights reserved.
//

import Foundation

class Photo: Equatable {

    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date

    init(
        title: String,
        remoteURL: URL,
        photoID: String,
        dateTaken: Date
    ) {

        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
    }

    static func ==(lhs: Photo, rhs: Photo) -> Bool {

        return lhs.photoID == rhs.photoID
    }
}
