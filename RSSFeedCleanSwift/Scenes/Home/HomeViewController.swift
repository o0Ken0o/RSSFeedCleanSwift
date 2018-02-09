//
//  HomeViewController.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class {
    
}

class HomeViewController: UIViewController {
    var router: HomeRoutingLogic?
    var interactor: HomeBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        self.view.backgroundColor = .lightGray
        
        setupVIPChain()
    }
    
    func setupVIPChain() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension HomeViewController: HomeDisplayLogic {
    
}
