//
//  HomeVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import UIKit

class HomeVC: UIViewController {
    let contentView: HomeView
    weak var flowDelegate: TabBarFlowDelegate?

    init(contentView: HomeView, flowDelegate: TabBarFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mwlBackground
        setup()
        navigationController?.isNavigationBarHidden = true
    }

    func setup() {
        view.backgroundColor = .mwlBackground
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView, safe: false)
       
        setupChildViewConstrollers()
      
    }

    private func setupChildViewConstrollers(){
        addViewController(
            childVC: BannerVC(viewModel: ShowViewModel()),
            to: contentView.bannerContainer
        )
        
        addViewController(
            childVC: PopularMoviesListVC(viewModel: ShowViewModel(), delegate: self),
            to: contentView.popularMoviesContainer
        )
        
        addViewController(
            childVC: PopularShowsListVC(viewModel: ShowViewModel(),delegate: self),
            to: contentView.popularShowsContainer
        )
        
        addViewController(
            childVC: TrendingMoviesListVC(viewModel: ShowViewModel(),delegate: self),
            to: contentView.trendingMoviesContainer
        )
        
        addViewController(
            childVC: TrendingShowsListVC(viewModel: ShowViewModel(),delegate: self),
            to: contentView.trendingShowsContainer
        )
    }
    
 

    private func addViewController(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}

extension HomeVC: MovieListDelegate {
    func movieDidTap(show: Show) {
        flowDelegate?.navigateToDetails(show: show)
    }
}

#Preview {
    HomeVC(contentView: HomeView())
}
