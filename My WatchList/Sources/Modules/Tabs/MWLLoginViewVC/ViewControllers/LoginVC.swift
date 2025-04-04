//
//  MWLLoginViewVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import UIKit
import AuthenticationServices

class LoginVC: UIViewController {

    weak var flowDelegate: TabBarFlowDelegate?
    let contentView: LoginView
    let viewModel: LoginViewModel
    
    init(contentView: LoginView, viewModel: LoginViewModel, flowDelegate: TabBarFlowDelegate? = nil) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(){
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)
        contentView.actionButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        view.backgroundColor = .mwlBackground
    }
    
    @objc
    private func didTapLoginButton(){
        Task { [weak self] in
            guard let self else {
                return
            }
            let (url, scheme) = try await self.viewModel.authenticate()
            
            let session = ASWebAuthenticationSession.init(url: url, callback: .customScheme(scheme)) { [weak self] callbackURL, error in
                guard let self else {
                    return
                }
                if let error {
                    print(error.localizedDescription)
                    flowDelegate?.presentLoginFailure()
                    return
                }
                
                guard let callbackURL else {
                    flowDelegate?.presentLoginFailure()
                    return
                }
                
                Task { [weak self] in
                    guard let self else {
                        return
                    }
                    guard
                        let params = callbackURL.getQueryparams(),
                        params["approved"] == "true",
                        let requestToken = params["request_token"]
                    else {
                        throw MWLError.invalidURL
                    }
                    
                    let username = try await viewModel.finishAuthentication(requestToken: requestToken)
                    dismiss(animated: true)
                    flowDelegate?.presentLoginSuccess(username: username)
                  
                }
            }
            session.presentationContextProvider = self
            
            DispatchQueue.main.async {
                session.start()
            }
        }
    }
    
}

extension LoginVC: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        view.window!
    }
}
