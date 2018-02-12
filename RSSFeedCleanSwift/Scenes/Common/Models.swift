//
//  Models.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 12/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

struct RSSFeed: Decodable {
    let title: String
    let id: String
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case songs = "results"
    }
}

struct Song: Decodable {
    let artistName: String
    let id: String
    let name: String
    let collectionName: String
    let artworkUrl100: String?
    let artistUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName, id, name, collectionName, artworkUrl100, artistUrl
    }
}