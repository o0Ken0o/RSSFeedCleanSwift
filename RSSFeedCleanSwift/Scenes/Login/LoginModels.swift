//
//  LoginModels.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

enum Login {
    enum TryLogin {
        struct Request {
            var username: String?
            var password: String?
        }
        
        struct Response {
            var isSuccessful: Bool
            var errorMsg: String?
        }
        
        struct ViewModel: Equatable {
            var isSuccessful: Bool
            var errorMsg: String
            
            static func ==(lhs: ViewModel, rhs: ViewModel) -> Bool {
                return lhs.isSuccessful == rhs.isSuccessful && lhs.errorMsg == rhs.errorMsg
            }
        }
    }
}
