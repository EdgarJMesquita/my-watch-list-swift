//
//  PopularMoviesListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/03/25.
//

import UIKit

class PopularMoviesListVC: MovieListVC {
    override func getTitle() -> String {
        "Popular movies"
    }
    
    override func getTraktType() -> TMDBType {
        .movie
    }
    
    override func getTraktCategory() -> TMDBCategory {
        .popular
    }
}


#Preview {
    PopularShowsListVC(viewModel: ShowViewModel(), currentIndex: 1)
}
