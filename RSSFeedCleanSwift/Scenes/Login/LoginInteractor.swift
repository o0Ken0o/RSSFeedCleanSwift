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
    var accountService: AccountServiceProtocol! = ServicesHolder.accountService
}

extension LoginInteractor: LoginBusinessLogic {
    func tryLogin(request: Login.TryLogin.Request) {
        accountService.trying2LoginIn(username: request.username, password: request.password) { [unowned self] (isSuccessful, errorMsg) in
            if isSuccessful {
                // store token locally
                
            }
            
            self.presenter?.presentLoginResponse(response: Login.TryLogin.Response(isSuccessful: isSuccessful, errorMsg: errorMsg))
        }
    }
}
