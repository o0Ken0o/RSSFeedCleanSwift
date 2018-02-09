//
//  LoginRouter.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

protocol LoginRoutingLogic {
    func go2HomeViewController()
}

class LoginRouter {
    weak var viewController: LoginViewController?
}

extension LoginRouter: LoginRoutingLogic {
    func go2HomeViewController() {
        let homeVC = HomeViewController()
        if let nav = viewController?.navigationController {
            nav.setViewControllers([homeVC], animated: true)
        } else {
            viewController?.present(homeVC, animated: true)
        }
    }
}
