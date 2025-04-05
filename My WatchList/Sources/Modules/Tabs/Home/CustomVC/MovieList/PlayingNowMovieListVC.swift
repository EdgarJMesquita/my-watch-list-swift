//
//  NowPlayingMovieListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import Foundation

class PlayingNowMovieListVC: MovieListVC {
    override func getTitle() -> String {
        "Playing now"
    }
    
    override func getTMDBType() -> TMDBType {
        .movie
    }
    
    override func getTMDBCategory() -> TMDBCategory {
        .nowPlaying
    }
}
