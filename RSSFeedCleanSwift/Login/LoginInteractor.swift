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

extension LoginInteractor: LoginBusinessLogic {
    func tryLogin(request: Login.TryLogin.Request) {
        trying2LoginIn(username: request.username, password: request.password) { [unowned self] (isSuccessful, errorMsg) in
            if isSuccessful {
                // store token locally
                
            }
            
            self.presenter?.presentLoginResponse(response: Login.TryLogin.Response(isSuccessful: isSuccessful, errorMsg: errorMsg))
        }
    }
}
