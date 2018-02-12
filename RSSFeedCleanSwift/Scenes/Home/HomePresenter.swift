//
//  HomePresenter.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation

protocol HomePresentationLogic {
    func presentSongs(response: Home.FetchSongs.Response)
    func presentFetchSongsError(errorMsg: String)
}

class HomePresenter {
    weak var viewController: HomeDisplayLogic?
}

extension HomePresenter: HomePresentationLogic {
    func presentSongs(response: Home.FetchSongs.Response) {
        // case 1: there is no songs to display
        // case 2: there are songs to display
    }
    
    func presentFetchSongsError(errorMsg: String) {
        
    }
}
