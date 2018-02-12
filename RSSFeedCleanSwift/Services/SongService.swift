//
//  SongService.swift
//  RSSFeedCleanSwift
//
//  Created by Ken Siu on 12/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import Foundation
import Alamofire

protocol SongServiceProtocol {
    func fetchSongs(completion: @escaping (Bool, Home.FetchSongsResponse?, String?) -> Void)
}

class SongService: SongServiceProtocol{
    func fetchSongs(completion: @escaping (Bool, Home.FetchSongsResponse?, String?) -> Void) {
        let requestStr = "https://rss.itunes.apple.com/api/v1/hk/apple-music/hot-tracks/all/50/explicit.json"
        
        Alamofire.request(requestStr).responseJSON { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else {
                    DispatchQueue.main.async {
                        let response = Home.FetchSongsResponse(feed: nil)
                        completion(true, response, nil)
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let fetchSongsResponse = try decoder.decode(Home.FetchSongsResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(true, fetchSongsResponse, nil)
                    }
                } catch {
                    // log the error
                    print(error.localizedDescription)
                    
                    let errorMsg = "Unknown error"
                    DispatchQueue.main.async {
                        completion(false, nil, errorMsg)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(false, nil, error.localizedDescription)
                }
            }
        }
    }
}
