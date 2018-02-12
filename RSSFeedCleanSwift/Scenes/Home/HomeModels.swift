//
//  HomeModels.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

enum Home {
    enum FetchSongs {
        struct Request {
            
        }
        
        struct Response: Decodable {
            let feed: RSSFeed?
        }
        
        struct ViewModel {
            let songs: [Song]
        }
        
        struct ErrorViewModel {
            let title: String
            let msg: String
            let errorImgName: String
        }
        
        struct Song {
            let artistName: String
            let name: String
            let collectionName: String
            let artworkUrl100: String
            let artistUrl: String
        }
    }
}
