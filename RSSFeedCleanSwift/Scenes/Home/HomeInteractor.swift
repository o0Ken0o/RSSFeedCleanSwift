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

class HomeInteractor {
    var presenter: HomePresentationLogic?
    var songSerivce: SongServiceProtocol?
}

extension HomeInteractor: HomeBusinessLogic {
    func fetchSongs() {
        songSerivce?.fetchSongs(completion: { [unowned self] (isSuccessful, customResponse, errorMsg) in
            if isSuccessful {
                guard let response = customResponse else { return }
                self.presenter?.presentSongs(response: response)
            } else {
                guard let errorMsg = errorMsg else { return }
                self.presenter?.presentFetchSongsError(errorMsg: errorMsg)
            }
        })
    }
}
