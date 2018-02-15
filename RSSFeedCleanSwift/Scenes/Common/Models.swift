//
//  Models.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 12/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation
/**
 all the structs in this file will be used for decoding data returned from the server
 **/
struct FetchedSongs: Decodable {
    let feed: RSSFeed?
}

struct RSSFeed: Decodable, Equatable {
    let title: String
    let id: String
    let songs: [Song]
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case songs = "results"
    }
    
    static func == (lhs: RSSFeed, rhs: RSSFeed) -> Bool {
        return lhs.title == rhs.title
            && lhs.id == rhs.id
            && lhs.songs == rhs.songs
    }
}

struct Song: Decodable, Equatable {
    let artistName: String
    let id: String
    let name: String
    let collectionName: String
    let artworkUrl100: String?
    let artistUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName, id, name, collectionName, artworkUrl100, artistUrl
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.artistName == rhs.artistName
            && lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.collectionName == rhs.collectionName
            && lhs.artworkUrl100 == rhs.artworkUrl100
            && lhs.artistUrl == rhs.artistUrl
    }
}
