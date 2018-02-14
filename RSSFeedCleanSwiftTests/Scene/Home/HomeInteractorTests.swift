//
//  HomeInteractorTests.swift
//  RSSFeedCleanSwiftTests
//
//  Created by Ken Siu on 13/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import XCTest
@testable import RSSFeedCleanSwift

class HomeInteractorTests: XCTestCase {
    
    var homeInteractor: HomeInteractor!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        createInteractor()
    }
    
    func createInteractor() {
        homeInteractor = HomeInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_FetchSongs_ShouldCallPresentSongsOrPresentSongsError() {
        let presenter = HomePresentationLogicMock()
        let songService = SongServiceProtocolSpy()
        homeInteractor.presenter = presenter
        homeInteractor.songSerivce = songService
        
        songService.isSuccessful = true
        songService.response = Home.FetchSongs.Response(feed: nil)
        homeInteractor.fetchSongs()
        XCTAssertTrue(presenter.verifyPresentFetchSongsIsCalled(), "Fetching songs successfully should call presentFetchSongs methods even no song returns")
        
        songService.isSuccessful = true
        let song = Song(artistName: "", id: "", name: "", collectionName: "", artworkUrl100: "", artistUrl: "")
        let songs = [song, song, song]
        songService.response = Home.FetchSongs.Response(feed: RSSFeed(title: "", id: "", songs: songs))
        homeInteractor.fetchSongs()
        XCTAssertTrue(presenter.verifyPresentFetchSongsIsCalled(), "Fetching songs successfully should call presentFetchSongs methods")
        
        songService.isSuccessful = false
        songService.errorMsg = ""
        homeInteractor.fetchSongs()
        XCTAssertTrue(presenter.verifyPresentFetchSongsErrorWasCalled(), "Having a failure during fetching songs should call presentFetchSongsError")
    }
    
    class SongServiceProtocolSpy: SongServiceProtocol {
        var isSuccessful = true
        var response: Home.FetchSongs.Response?
        var errorMsg: String?
        
        func fetchSongs(completion: @escaping (Bool, Home.FetchSongs.Response?, String?) -> Void) {
            completion(isSuccessful, response, errorMsg)
        }
    }
    
    class HomePresentationLogicMock: HomePresentationLogic {
        private var presentFetchSongsErrorWasCalled = false
        private var presentSongsWasCalled = false
        
        func presentFetchSongsError(errorMsg: String) {
            presentFetchSongsErrorWasCalled = true
        }
        
        func presentSongs(response: Home.FetchSongs.Response) {
            presentSongsWasCalled = true
        }
        
        func verifyPresentFetchSongsIsCalled() -> Bool {
            return presentSongsWasCalled
        }
        
        func verifyPresentFetchSongsErrorWasCalled() -> Bool {
            return presentFetchSongsErrorWasCalled
        }
        
        func verifyAtLeastOneFunctionIsCalled() -> Bool {
            return presentSongsWasCalled || presentFetchSongsErrorWasCalled
        }
    }
    
}
