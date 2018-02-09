//
//  LoginInteractor.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic {
    func tryLogin(request: Login.TryLogin.Request)
}

class LoginInteractor {
    var presenter: LoginPresentationLogic?
    
    func isValidAccount(username: String?, password: String?) -> Bool {
        if let username = username, let password = password {
            if username == "ken.siu@accedo.tv", password == "rock" {
                // login success
                return true
            }
        }
        
        // login failure
        return false
    }
}

extension LoginInteractor: LoginBusinessLogic {
    func tryLogin(request: Login.TryLogin.Request) {
        if isValidAccount(username: request.username, password: request.password) {
            print("login success")
        } else {
            print("login failure")
        }
    }
}
