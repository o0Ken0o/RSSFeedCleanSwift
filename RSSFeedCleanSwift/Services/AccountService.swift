//
//  AccountService.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

/**
 services related to login, sign up, changing pw, sign up using facebook, sign up using goolge are included in Account AccountServiceProtocol
**/
protocol AccountServiceProtocol {
    func trying2LoginIn(username: String?, password: String?, completion: @escaping (Bool, String?) -> Void)
}

class AccountService: AccountServiceProtocol {
    func trying2LoginIn(username: String?, password: String?, completion: @escaping (Bool, String?) -> Void) {
        guard let username = username, let password = password else {
            // needs to call completion in main thread
            completion(false, "Either username or password is missing.")
            return
        }
        
        if username == "ken.siu@accedo.tv" {
            if password == "new" {
                // needs to call completion in main thread
                completion(true, "")
            } else if password == "old" {
                // needs to call completion in main thread
                completion(false, "You have entered the old password")
            } else {
                // needs to call completion in main thread
                completion(false, "Password is not correct")
            }
        } else {
            completion(false, "No such user")
        }
    }
}
