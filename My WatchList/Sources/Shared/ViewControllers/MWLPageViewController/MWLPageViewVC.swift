//
//  FavoritesVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 30/03/25.
//

import UIKit
import Hero

class MWLPageViewVC: UIPageViewController {
    
    private var pages: [UIViewController] = []
    private var items:[String] = []
    private var segmentedControl: UISegmentedControl?
    
    weak var flowDelegate: TabBarFlowDelegate?
    
    func getPages() -> [UIViewController] {
        fatalError("getPages() has not been implemented")
    }
    
    func getPagesNames() -> [String] {
        fatalError("getPagesNames() has not been implemented")
    }
    
    init(flowDelegate: TabBarFlowDelegate? = nil) {
        self.flowDelegate = flowDelegate
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        dataSource = self
        delegate = self
        
        self.pages = getPages()
        self.items = getPagesNames()
        self.hero.isEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageController()
        setupSegmentedControl()
    }
    
    private func setupPageController() {
//        let favoritesMoviesVC = FavoritesListVC(
//            contentView: FavoritesListView(),
//            viewModel: FavoritesViewModel(),
//            type: .movies,
//            flowDelegate: flowDelegate
//        )
////        let favoritesMoviesNC = UINavigationController(rootViewController: favoritesMoviesVC)
//        let favoritesTvVC = FavoritesListVC(
//            contentView: FavoritesListView(),
//            viewModel: FavoritesViewModel(),
//            type: .tv,
//            flowDelegate: flowDelegate
//        )
////        let favoritesTvNC = UINavigationController(rootViewController: favoritesTvVC)
//        pages = [
//            favoritesMoviesVC,
//            favoritesTvVC,
//        ]
        
        if let firstViewController = pages.first  {
            setViewControllers([firstViewController], direction: .forward, animated: false)
        }
       
    }
    
    private func setupSegmentedControl(){
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didSelect(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
        self.segmentedControl = segmentedControl
        
    }
    
    @objc
    private func didSelect(_ sender: UISegmentedControl){
        let selectedIndex = sender.selectedSegmentIndex
       
        let selectedViewController = pages[selectedIndex]
        
        setViewControllers(
            [selectedViewController],
            direction: selectedIndex == 0 ? .reverse : .forward,
            animated: true)
    }
    
}



extension MWLPageViewVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        let pagesCount = pages.count
        
        guard nextIndex != pagesCount else {
            return nil
        }
        
        guard pagesCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first else {
            return
        }
        guard let viewControllerIndex = pages.firstIndex(of:viewController) else {
            return
        }
        
        segmentedControl?.selectedSegmentIndex = viewControllerIndex
    }
    
}

extension MWLPageViewVC: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
}
