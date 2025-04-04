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
    
    override func getTraktType() -> TMDBType {
        .movie
    }
    
    override func getTraktCategory() -> TMDBCategory {
        .nowPlaying
    }
}
