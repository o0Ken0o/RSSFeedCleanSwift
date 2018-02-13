//
//  HomeInteractor.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation
import Alamofire

protocol HomeBusinessLogic {
    func fetchSongs()
}

protocol HomeDataStore {
    var songs: [Song]? { get }
}

class HomeInteractor {
    var presenter: HomePresentationLogic?
    var songSerivce: SongServiceProtocol?
    var _songs: [Song]?
}

extension HomeInteractor: HomeDataStore {
    // This list is a list of songs fetched from the server. It is subject to data formatting before display
    // Also, individual elements can be passed as data to other scene (like detailed album)
    var songs: [Song]? {
        return _songs
    }
}

extension HomeInteractor: HomeBusinessLogic {
    func fetchSongs() {
        songSerivce?.fetchSongs(completion: { [unowned self] (isSuccessful, customResponse, errorMsg) in
            if isSuccessful {
                guard let response = customResponse else { return }
                self._songs = response.feed?.songs
                self.presenter?.presentSongs(response: response)
//                self.presenter?.presentSongs(response: Home.FetchSongs.Response(feed: nil))
            } else {
                guard let errorMsg = errorMsg else { return }
                self.presenter?.presentFetchSongsError(errorMsg: errorMsg)
            }
        })
    }
}
