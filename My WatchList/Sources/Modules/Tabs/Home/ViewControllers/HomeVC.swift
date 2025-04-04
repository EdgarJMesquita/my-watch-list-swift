//
//  HomeVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import UIKit

class HomeVC: MWLDataLoadingVC {
    let contentView: HomeView
    weak var flowDelegate: TabBarFlowDelegate?
    private let currentIndex: Int

    init(contentView: HomeView, flowDelegate: TabBarFlowDelegate? = nil, previousIndex: Int) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        self.currentIndex = previousIndex
        super.init(nibName: nil, bundle: nil)
        
        self.hero.isEnabled = true
       
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mwlBackground
        setup()
        showLoadingView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationItem()
    }
    
    private func setupNavigationItem(){
        navigationController?.isNavigationBarHidden = true
        navigationItem.backButtonTitle = "Home"
    }
 
    func setup() {
        view.backgroundColor = .mwlBackground
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView, safe: false)
       
        setupChildViewConstrollers()
    }

    private func setupChildViewConstrollers(){

   
        addViewController(
            childVC: BannerVC(
                viewModel: BannerViewModel(),
                currentIndex: currentIndex,
                delegate: self,
                flowDelegate: flowDelegate
            ),
            to: contentView.bannerContainer
        )
        
        let viewControllers: [UIViewController] = [
            UpcomingMoviesListVC(
                viewModel: ShowViewModel(),
                delegate: self,
                currentIndex: currentIndex
            ),
            PopularShowsListVC(
                viewModel: ShowViewModel(),
                delegate: self,
                currentIndex: currentIndex
            ),
            PopularMoviesListVC(
                viewModel: ShowViewModel(),
                delegate: self,
                currentIndex: currentIndex
            ),
            AiringTodayShowsListVC(
                viewModel: ShowViewModel(),
                delegate: self,
                currentIndex: currentIndex
            ),
            TopRatedMoviesListVC(
                viewModel: ShowViewModel(),
                delegate: self,
                currentIndex: currentIndex
            ),
            TopRatedShowListVC(
                viewModel: ShowViewModel(),
                delegate: self,
                currentIndex: currentIndex
            ),
            PlayingNowMovieListVC(
                viewModel: ShowViewModel(),
                delegate: self,
                currentIndex: currentIndex
            ),
            OnTheAirShowListVC(
                viewModel: ShowViewModel(),
                delegate: self,
                currentIndex: currentIndex
            )
        ]
        
        contentView.setupContainers(count: viewControllers.count)
        
        for (index,container) in contentView.containers.enumerated() {
            addViewController(childVC: viewControllers[index], to: container)
        }
  
    }
    
    private func addViewController(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}

extension HomeVC: MovieListDelegate, BannerDelegate {
    func movieDidTap(show: Media) {
        flowDelegate?.presentShowDetails(id: show.id, posterPath: show.posterPath, type: show.getType())
    }
    
    func didFinishLoading() {
        dismissLoadingView(delay: 1)
    }
}

#Preview {
    HomeVC(contentView: HomeView(), previousIndex: 1)
}
