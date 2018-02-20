//
//  HomeViewControllerTests.swift
//  RSSFeedCleanSwiftTests
//
//  Created by Ken Siu on 20/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import XCTest
@testable import RSSFeedCleanSwift

class HomeViewControllerTests: XCTestCase {
    
    var homeViewController: HomeViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        createHomeViewController()
        createWindow()
    }
    
    func createHomeViewController() {
        homeViewController = HomeViewController()
    }
    
    func createWindow() {
        window = UIWindow()
    }
    
    func loadView() {
        window.addSubview(homeViewController.view)
        window.makeKeyAndVisible()
        RunLoop.current.run(until: Date())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_ViewDidLoadShouldCallInteractorToFetchSongs() {
        let interactor = HomeBusinessLogicSpy()
        let homeConfigurationSpy = HomeConfiguratorSpy()
        homeConfigurationSpy.interactor = interactor
        homeViewController.configurator = homeConfigurationSpy
        
        // trigger viewDidLoad
        loadView()
        
        XCTAssert(interactor.fetchSongsWasCalled, "HomeViewController should have called interactor to fetch songs after view is loaded.")
    }
    
    class HomeConfiguratorSpy: HomeConfigurationDelegate {
        var interactor: HomeBusinessLogicSpy!
        
        func configureWith(viewController: HomeViewController) {
            viewController.interactor = interactor
        }
    }
    
    class HomeBusinessLogicSpy: HomeBusinessLogic {
        var fetchSongsWasCalled = false
        
        func fetchSongs() {
            fetchSongsWasCalled = true
        }
    }
}
