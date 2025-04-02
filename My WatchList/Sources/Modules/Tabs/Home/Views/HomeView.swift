//
//  HomeView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import UIKit

class HomeView: UIView {

    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    var containers: [UIView] = []
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bannerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//
//    
//    lazy var popularMoviesContainer: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    lazy var popularShowsContainer: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    
//    lazy var trendingMoviesContainer: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    lazy var trendingShowsContainer: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
   
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupUI() {
        setupHierarchy()
    }

    private func setupHierarchy() {
        contentView.addSubview(bannerContainer)

        scrollView.addSubview(contentView)
        
        addSubview(scrollView)
    }
    
    
    func setupContainers(count listCount: Int) {
           
        scrollView.pinToEdges(of: self)
        
        contentView.pinToEdges(of: scrollView)
        
        let stackButtonHeight: CGFloat = 48
        
        let bannerHeight: CGFloat = 430
        let movieListHeight: CGFloat = 244
        let movieListSpacing: CGFloat = 32
        
     
        
        for index in 0..<listCount {
            let container = UIView()
            container.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(container)
            
            NSLayoutConstraint.activate([
                container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                container.heightAnchor.constraint(equalToConstant: movieListHeight),
            ])
            
            if index == 0 {
                container.topAnchor.constraint(
                    equalTo: bannerContainer.bottomAnchor
                ).isActive = true
            } else {
                // constraint current top anchor to previous view's bottom ancher
                container.topAnchor.constraint(
                    equalTo: self.containers[index - 1].bottomAnchor,
                    constant: movieListSpacing
                ).isActive = true
            }
            
            self.containers.append(container)
        }
        
        
        let moviesShowsSectionHeight:CGFloat = (movieListHeight + movieListSpacing) * CGFloat(integerLiteral: containers.count) + 100
        
        let contentHeight: CGFloat = bannerHeight + (stackButtonHeight - 3) + moviesShowsSectionHeight
    
     
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: contentHeight),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            bannerContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerContainer.heightAnchor.constraint(equalToConstant: bannerHeight),

        ])
    }

}

#Preview {
    HomeVC(contentView: HomeView(),previousIndex: 1)
}
