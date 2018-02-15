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
    
    func test_FetchSongs_ShouldCallPresenterToPresentSongs() {
        let presenter = HomePresentationLogicMock()
        let songService = SongServiceProtocolSpy()
        homeInteractor.presenter = presenter
        homeInteractor.songSerivce = songService
        
        homeInteractor.fetchSongs()
        XCTAssertTrue(presenter.verifyPresentSonsWasCalled(), "Fetching songs should call presenter to present songs")
    }
    
    func test_FetchSongs_ShouldReturnTheResponse() {
        // prepare
        let presenter = HomePresentationLogicMock()
        let songService = SongServiceProtocolSpy()
        homeInteractor.presenter = presenter
        homeInteractor.songSerivce = songService
        
        let song = Song(artistName: "", id: "", name: "", collectionName: "", artworkUrl100: "", artistUrl: "")
        let songs = [song, song, song]
        let feed = RSSFeed(title: "", id: "", songs: songs)
        let fetchSongs = FetchedSongs(feed: feed)
        let isSuccessful = true
        let errorMsg = ""
        
        songService.isSuccessful = isSuccessful
        songService.fetchedSongs = fetchSongs
        songService.errorMsg = errorMsg
        
        // when
        homeInteractor.fetchSongs()
        
        // then
        let expectedResponse = Home.FetchSongs.Response(feed: feed, isSuccessful: isSuccessful, errorMsg: errorMsg)
        XCTAssertTrue(presenter.verifyWith(response: expectedResponse), "Fetching songs should return the response from the server")
    }
    
    func test_GetSongsShouldReturnUnformattedSongsForRouter() {
        let songService = SongServiceProtocolSpy()
        homeInteractor.songSerivce = songService

        XCTAssertNil(homeInteractor.songs, "No songs should have been stored before fetching")

        songService.isSuccessful = true
        let song = Song(artistName: "", id: "", name: "", collectionName: "", artworkUrl100: "", artistUrl: "")
        let songs = [song, song, song]
        let fetchSongs = FetchedSongs(feed: RSSFeed(title: "", id: "", songs: songs))
        songService.fetchedSongs = fetchSongs
        homeInteractor.fetchSongs()

        XCTAssertNotNil(homeInteractor.songs, "There should be a song stored after a successful fetch")
        XCTAssertEqual(homeInteractor.songs!, songs, "HomeIterator should return unformatted songs as a data store.")
    }
    
    class SongServiceProtocolSpy: SongServiceProtocol {
        var isSuccessful = true
        var fetchedSongs: FetchedSongs?
        var errorMsg: String?
        
        func fetchSongs(completion: @escaping (Bool, FetchedSongs?, String?) -> Void) {
            completion(isSuccessful, fetchedSongs, errorMsg)
        }
    }
    
    class HomeDataStoreMock: HomeDataStore {
        var songs: [Song]?
    }
    
    class HomePresentationLogicMock: HomePresentationLogic {
        private var presentSongsWasCalled = false
        private var home_FetchSongs_Response: Home.FetchSongs.Response!
        
        func presentSongs(response: Home.FetchSongs.Response) {
            presentSongsWasCalled = true
            home_FetchSongs_Response = response
        }
        
        func verifyPresentSonsWasCalled() -> Bool {
            return presentSongsWasCalled
        }
        
        func verifyWith(response: Home.FetchSongs.Response) -> Bool {
            return home_FetchSongs_Response == response
        }
    }
    
}
