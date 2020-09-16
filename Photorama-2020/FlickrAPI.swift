//
//  FlickrAPI.swift
//  Photorama-2020
//
//  Created by Seyfeddin Bassarac on 16.05.2020.
//  Copyright © 2020 Medipol. All rights reserved.
//

import Foundation

enum FlickrError: Error {
    case invalidJSONData
}

enum Method: String {
    case interestingPhotos = "flickr.interestingness.getList"
}

struct FlickrAPI {

    private static let baseURL = "https://api.flickr.com/services/rest"
    private static let apiKey = "535c7e68f6b25957ced3031b7099b240"

    private static func flickrURL(
        method: Method,
        parameters: [String: String]?
    ) -> URL {
        var components = URLComponents(string: baseURL)!

        var queryItems: [URLQueryItem] = []

        let baseParams = [
            "method": method.rawValue,
            "format": "json",
            "nojsoncallback": "1",
            "api_key": apiKey
        ]

        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }

        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }

        components.queryItems = queryItems

        return components.url!
    }

    static var interestingPhotosURL: URL {
        return flickrURL(method: .interestingPhotos, parameters: ["extras": "url_h,date_taken"])
    }
}
