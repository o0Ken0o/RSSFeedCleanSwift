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
}

class HomePresenter {
    weak var viewController: HomeDisplayLogic?
}

extension HomePresenter: HomePresentationLogic {
    func presentSongs(response: Home.FetchSongs.Response) {
        let presentClosure = response.isSuccessful ? presentFetchedSongsSuccessfully : presentFetchedSongsError
        presentClosure(response)
    }
    
    private func presentFetchedSongsSuccessfully(response: Home.FetchSongs.Response) {
        guard response.isSuccessful else { return }
        
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
    
    private func presentFetchedSongsError(response: Home.FetchSongs.Response) {
        guard !response.isSuccessful else { return }
        
        // may try to parse the errorMsg and format it according to needs
        switch response.errorMsg {
        case nil:
            break
        default:
            break
        }
        
        let errorVM = Home.FetchSongs.ViewModel.Error(title: ApiError.Title.universial, msg: ApiError.Message.pullDownToRefresh, errorImgName: ApiError.ImgName.warning)
        viewController?.display(errorViewModel: errorVM)
    }
}
