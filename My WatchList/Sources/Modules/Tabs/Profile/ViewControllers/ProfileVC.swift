//
//  ProfileVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import UIKit

class ProfileVC: MWLBaseViewController {
    
    
    let contentView: ProfileView
    let viewModel: ProfileViewModel
    weak var flowDelegate: TabBarFlowDelegate?
    
    
    init(contentView: ProfileView, viewModel: ProfileViewModel) {
        self.contentView = contentView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.loadData()
        showLoadingView()
    }
    
    
    private func setup(){
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)
        view.backgroundColor = .mwlBackground
        setupLogout()
        setupUserRatedMedia()
    }
    
    
    private func configure(with user: User){
        Task {
            dismissLoadingView(delay: 1)
            contentView.titleLabel.text = !user.name.isEmpty ? user.name : user.username
           
            if let tmdbAvatar = user.avatar.tmdb.avatarPath {
                contentView.avatarImageView.image = await ImageService.shared.downloadTMDBImage(path: tmdbAvatar)
            } else {
                contentView.avatarImageView.image = await ImageService.shared.downloadGravatar(hash: user.avatar.gravatar.hash)
            }
        }
    }
    
    
    private func setupLogout(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Exit",
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
    }
    
    @objc
    private func didTapLogout(){
        let alertController = UIAlertController(
            title: "Loggin out",
            message: "Do you really wanna logout?",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(
            UIAlertAction(
                title: "Yes",
                style: .destructive,
                handler: { _ in
                    self.logout()
                }
             )
        )
        present(alertController, animated: true)
    }
    
    private func logout(){
        viewModel.logout()
        flowDelegate?.resetApp()
    }
    
    private func setupUserRatedMedia(){
        let ratedMoviesListVC = UserRatedMoviesListVC(viewModel: UserRatedListViewModel(), delegate: self, currentIndex: 1)
        
        addViewController(
            childVC: ratedMoviesListVC,
            to: contentView.ratedMovieListContainer
        )
        
        let ratedTVListVC = UserRatedTVListVC(viewModel: UserRatedListViewModel(), delegate: self, currentIndex: 1)
        
        addViewController(
            childVC: ratedTVListVC,
            to: contentView.ratedTVListContainer
        )
    }
    
    private func addViewController(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension ProfileVC: ProfileViewModelDelegate {
    func didLoadAccountDetails(user: User) {
        configure(with: user)
    }
}

extension ProfileVC: MWLUserRatedListDelegate {
    func didTapSeeMore() {
        flowDelegate?.navigateToRatedListPageView()
    }
    
    func didTapMedia(media: Media) {
        flowDelegate?.presentShowDetails(
            id: media.id,
            posterPath: media.getImagePath(), 
            type: media.getType()
        )
    }
}

#Preview {
    ProfileVC(contentView: ProfileView(), viewModel: ProfileViewModel())
}

