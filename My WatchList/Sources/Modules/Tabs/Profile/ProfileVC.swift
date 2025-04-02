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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
        viewModel.loadData()
        
        if viewModel.isLogged {
            dismissLoginView()
        } else {
            showLoginView()
        }
        
        showLoadingView()
    }
    
    private func setup(){
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)
        view.backgroundColor = .mwlBackground
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
    
    @objc
    private func authenticate(){
        viewModel.authenticate()
    }
    
}

extension ProfileVC: ProfileViewModelDelegate {
    func didLoadAccountDetails(user: User) {
        configure(with: user)
    }
}

#Preview {
    ProfileVC(contentView: ProfileView(), viewModel: ProfileViewModel())
}
