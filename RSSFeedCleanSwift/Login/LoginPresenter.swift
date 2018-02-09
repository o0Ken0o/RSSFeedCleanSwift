//
//  LoginPresenter.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

protocol LoginPresentationLogic {
    func presentLoginResponse(response: Login.TryLogin.Response)
}

class LoginPresenter {
    // use weak here to avoid retain cycle in VIP chain
    weak var viewController: LoginDisplayLogic?
}

extension LoginPresenter: LoginPresentationLogic {
    func presentLoginResponse(response: Login.TryLogin.Response) {
        let isSuccessful = response.isSuccessful
        let errorMsg = response.errorMsg ?? ""
        let viewModel = Login.TryLogin.ViewModel(isSuccessful: isSuccessful, errorMsg: errorMsg)
        viewController?.displayLogin(viewModel: viewModel)
    }
}
