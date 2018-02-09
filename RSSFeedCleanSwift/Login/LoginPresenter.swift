//
//  LoginPresenter.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

protocol LoginPresentationLogic {
    
}

class LoginPresenter {
    // use weak here to avoid retain cycle in VIP chain
    weak var viewController: LoginDisplayLogic?
}

extension LoginPresenter: LoginPresentationLogic {
    
}
