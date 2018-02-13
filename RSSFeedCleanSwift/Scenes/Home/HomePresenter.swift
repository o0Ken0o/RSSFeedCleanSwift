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
        guard let rawSongs = response.feed?.songs else {
            viewController?.displayEmptySongsList()
            return
        }
        
        // case 2: there are songs to display
        let songs = rawSongs.map{
            Home.FetchSongs.ViewModel.DisplaySong(artistName: $0.artistName,
                                 name: $0.name,
                                 collectionName: $0.collectionName,
                                 artworkUrl100: $0.artworkUrl100 ?? "",
                                 artistUrl: $0.artistUrl ?? "")
        }
        let viewModel = Home.FetchSongs.ViewModel(songs: songs)
        viewController?.displaySongs(viewModel: viewModel)
    }
    
    func presentFetchSongsError(errorMsg: String) {
        
    }
}
