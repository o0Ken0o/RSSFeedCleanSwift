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
        
        struct Response: Equatable {
            let feed: RSSFeed?
            let isSuccessful: Bool
            let errorMsg: String?
            
            static func == (lhs: Response, rhs: Response) -> Bool {
                return lhs.feed == rhs.feed
                    && lhs.isSuccessful == rhs.isSuccessful
                    && lhs.errorMsg == rhs.errorMsg
            }
        }
        
        struct ViewModel {
            struct DisplaySong {
                let artistName: String
                let name: String
                let collectionName: String
                let artworkUrl100: String
                let artistUrl: String
            }
            
            let songs: [DisplaySong]
            
            struct Error {
                let title: String
                let msg: String
                let errorImgName: String
            }
        }
    }
}
