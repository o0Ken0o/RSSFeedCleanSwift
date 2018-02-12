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
        songSerivce?.fetchSongs(completion: { (isSuccessful, customResponse, errorMsg) in
            if isSuccessful {
                print(customResponse)
            } else {
                print(errorMsg ?? "default error msg")
            }
        })
    }
}
