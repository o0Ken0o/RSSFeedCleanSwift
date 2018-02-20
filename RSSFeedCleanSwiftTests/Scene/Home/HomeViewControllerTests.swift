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
    
    func test_NumberOfSectionsInSongsListIs1() {
        let tableView = homeViewController.tableView
        let numberOfSection = homeViewController.numberOfSections(in: tableView)
        let expectedNumberOfSection = 1
        XCTAssertEqual(numberOfSection, expectedNumberOfSection, "number of sections in songs list should be 1.")
    }
    
    func test_NumberOfRowsInSection0IsTheNumberOfSongsOfDisplaySongs() {
        let tableView = homeViewController.tableView
        let displaySong = Home.FetchSongs.ViewModel.DisplaySong(artistName: "", name: "", collectionName: "", artworkUrl100: "", artistUrl: "")
        let displaySongs = [displaySong, displaySong, displaySong, displaySong]
        homeViewController.displaySongs = displaySongs
        
        let numberOfRowsInSection0 = homeViewController.tableView(tableView, numberOfRowsInSection: 0)
        let expectedNumberOfRowsInSection0 = displaySongs.count
        XCTAssertEqual(numberOfRowsInSection0, expectedNumberOfRowsInSection0, "number of rows in section 0 should be equal to the number of display songs")
    }
    
    func test_CellForRowsInSection0ShouldConfigureWithTheCorrespondingDisplaySong() {
        let tableView = homeViewController.tableView
        let displaySong = Home.FetchSongs.ViewModel.DisplaySong(artistName: "artistName", name: "name", collectionName: "collectionName", artworkUrl100: "", artistUrl: "")
        let displaySongs = [displaySong]
        homeViewController.displaySongs = displaySongs
        
        loadView()
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! SongTableViewCell
        
        XCTAssertEqual(cell.albumNameLabel.text, "collectionName")
        XCTAssertEqual(cell.artistNameLabel.text, "artistName")
    }
    
    func test_HeightForRowShouldReturn80() {
        let tableView = homeViewController.tableView
        let displaySong = Home.FetchSongs.ViewModel.DisplaySong(artistName: "", name: "", collectionName: "", artworkUrl100: "", artistUrl: "")
        let displaySongs = [displaySong, displaySong, displaySong, displaySong]
        homeViewController.displaySongs = displaySongs
        
        var heights: [CGFloat] = []
        for i in 0..<displaySongs.count {
            heights.append(homeViewController.tableView(tableView, heightForRowAt: IndexPath(row: i, section: 0)))
        }
        
        let expectedHeights: [CGFloat] = [80, 80, 80, 80]
        XCTAssertEqual(heights, expectedHeights, "Height of each row should be equal to 80")
    }
    
    func test_SelectARowShouldDeselectItAutomatically() {
        let tableView = homeViewController.tableView
        let displaySong = Home.FetchSongs.ViewModel.DisplaySong(artistName: "", name: "", collectionName: "", artworkUrl100: "", artistUrl: "")
        let displaySongs = [displaySong, displaySong, displaySong, displaySong]
        homeViewController.displaySongs = displaySongs
        
        loadView()
        
        homeViewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertFalse(tableView.cellForRow(at: IndexPath(row: 0, section: 0))!.isSelected)
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
