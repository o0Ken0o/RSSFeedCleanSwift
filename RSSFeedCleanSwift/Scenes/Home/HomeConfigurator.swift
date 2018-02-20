//
//  HomeConfigurator.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 20/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import UIKit

protocol HomeConfigurationDelegate: class {
    func configureWith(viewController: HomeViewController)
}

class HomeConfigurator: HomeConfigurationDelegate {
    func configureWith(viewController: HomeViewController) {
        let homeViewController = viewController
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        homeViewController.router = router
        homeViewController.interactor = interactor
        interactor.presenter = presenter
        interactor.songSerivce = ServicesHolder.songService
        presenter.viewController = homeViewController
    }
}
