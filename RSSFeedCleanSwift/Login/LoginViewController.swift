//
//  LoginViewController.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: class {
    
}

class LoginViewController: UIViewController {
    var router: LoginRoutingLogic?
    var interactor: LoginBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        self.view.backgroundColor = .white
        setupVIPChain()
    }
    
    private func setupVIPChain() {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension LoginViewController: LoginDisplayLogic {
    
}


