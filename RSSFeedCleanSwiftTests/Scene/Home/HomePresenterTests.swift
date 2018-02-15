//
//  HomePresenterTests.swift
//  RSSFeedCleanSwiftTests
//
//  Created by Ken Siu on 15/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import XCTest
@testable import RSSFeedCleanSwift

class HomePresenterTests: XCTestCase {
    
    var presenter: HomePresenter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        createPresenter()
    }
    
    func createPresenter() {
        presenter = HomePresenter()
    }
    
    func test_PresenterPresentsAListOfSongsForFetchingSongs_ShouldCallViewControllerDisplaySongs() {
        let viewController = HomeDisplayLogicSpy()
        presenter.viewController = viewController
        
        let song = Song(artistName: "", id: "", name: "", collectionName: "", artworkUrl100: "", artistUrl: "")
        let songs = [song, song, song]
        let feed = RSSFeed(title: "", id: "", songs: songs)
        let errorMsg: String? = nil
        let response = Home.FetchSongs.Response(feed: feed, isSuccessful: true, errorMsg: errorMsg)
        presenter.presentSongs(response: response)
        
        XCTAssert(viewController.displaySongsWasCalled, "Presenting a list of songs for fetching songs should call viewController to display songs")
    }
    
    func test_PresenterPresentsAListOfSongsForFetchingSongs_ShouldReturnTheRightViewModel() {
        let viewController = HomeDisplayLogicSpy()
        presenter.viewController = viewController
        
        let song = Song(artistName: "", id: "", name: "", collectionName: "", artworkUrl100: "", artistUrl: "")
        let songs = [song, song, song]
        let feed = RSSFeed(title: "", id: "", songs: songs)
        let errorMsg: String? = nil
        let response = Home.FetchSongs.Response(feed: feed, isSuccessful: true, errorMsg: errorMsg)
        presenter.presentSongs(response: response)
        
        
        let displaySongs = songs.map{
            Home.FetchSongs.ViewModel.DisplaySong(artistName: $0.artistName, name: $0.artistName, collectionName: $0.collectionName, artworkUrl100: $0.artworkUrl100 ?? "", artistUrl: $0.artistUrl ?? "")
        }
        let viewModel = Home.FetchSongs.ViewModel(songs: displaySongs)
        XCTAssertEqual(viewController.home_FetchSongs_ViewModel, viewModel, "Presenting a list of songs for fetching songs should return the right view model")
    }
    
    func test_PresenterPresentsAnEmptyListOfSongsForFetchingSongs_ShouldCallViewControllerDisplayEmptyListOfSongs() {
        let viewController = HomeDisplayLogicSpy()
        presenter.viewController = viewController
        
        let feed: RSSFeed? = nil
        let errorMsg: String? = nil
        let response = Home.FetchSongs.Response(feed: feed, isSuccessful: true, errorMsg: errorMsg)
        presenter.presentSongs(response: response)
        
        XCTAssert(viewController.displayEmptySongsListCalled, "Presenting an empty list of songs for fetching songs should call viewController to display songs")
    }
    
    // since there is no viewModel to return, no assertion needed
    func test_PresenterPresentsAnEmptyListOfSongsForFetchingSongs_ShouldReturnTheRightViewModel() {
        let viewController = HomeDisplayLogicSpy()
        presenter.viewController = viewController
        
        let feed: RSSFeed? = nil
        let errorMsg: String? = nil
        let response = Home.FetchSongs.Response(feed: feed, isSuccessful: true, errorMsg: errorMsg)
        presenter.presentSongs(response: response)
    }
    
    func test_PresenterPresentsErrorForFetchingSongs_ShouldCallViewControllerDisplayError() {
        let viewController = HomeDisplayLogicSpy()
        presenter.viewController = viewController
        
        let feed: RSSFeed? = nil
        let errorMsg: String? = "Error"
        let response = Home.FetchSongs.Response(feed: feed, isSuccessful: false, errorMsg: errorMsg)
        presenter.presentSongs(response: response)
        
        XCTAssert(viewController.displayErrorWasCalled, "Presenting error for fetching songs should call viewController to display error.")
    }
    
    func test_PresenterPresentsErrorForFetchingSongs_ShouldReturnTheRightError() {
        let viewController = HomeDisplayLogicSpy()
        presenter.viewController = viewController
        
        let feed: RSSFeed? = nil
        let errorMsg: String? = "Error"
        let response = Home.FetchSongs.Response(feed: feed, isSuccessful: false, errorMsg: errorMsg)
        presenter.presentSongs(response: response)
        
        let errorViewModel = Home.FetchSongs.ViewModel.Error(title: ApiError.Title.universial, msg: ApiError.Message.pullDownToRefresh, errorImgName: ApiError.ImgName.warning)
        XCTAssert(viewController.home_FetchSongs_ViewModel_Error == errorViewModel, "Presenting an error for fetching songs should return the right error")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    class HomeDisplayLogicSpy: HomeDisplayLogic {
        private(set) var displaySongsWasCalled = false
        private(set) var displayErrorWasCalled = false
        private(set) var displayEmptySongsListCalled = false
        
        private(set) var home_FetchSongs_ViewModel: Home.FetchSongs.ViewModel!
        private(set) var home_FetchSongs_ViewModel_Error: Home.FetchSongs.ViewModel.Error!
        
        func displaySongs(viewModel: Home.FetchSongs.ViewModel) {
            displaySongsWasCalled = true
            home_FetchSongs_ViewModel = viewModel
        }
        
        func display(errorViewModel: Home.FetchSongs.ViewModel.Error) {
            displayErrorWasCalled = true
            home_FetchSongs_ViewModel_Error = errorViewModel
        }
        
        func displayEmptySongsList() {
            displayEmptySongsListCalled = true
        }
    }
}
