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
        
        struct ViewModel: Equatable {
            let songs: [DisplaySong]
            
            struct DisplaySong: Equatable {
                let artistName: String
                let name: String
                let collectionName: String
                let artworkUrl100: String
                let artistUrl: String
                
                static func == (lhs: DisplaySong, rhs: DisplaySong) -> Bool {
                    return lhs.artistName == rhs.artistName
                        && lhs.name == rhs.name
                        && lhs.collectionName == rhs.collectionName
                        && lhs.artworkUrl100 == rhs.artworkUrl100
                        && lhs.artistUrl == rhs.artistUrl
                }
            }
            
            struct Error {
                let title: String
                let msg: String
                let errorImgName: String
                
                static func == (lhs: Error, rhs: Error) -> Bool {
                    return lhs.title == rhs.title
                        && lhs.msg == rhs.msg
                        && lhs.errorImgName == rhs.errorImgName
                }
            }
            
            static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
                return lhs.songs == rhs.songs
            }
        }
    }
}
