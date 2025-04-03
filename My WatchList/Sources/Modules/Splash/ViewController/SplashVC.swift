//
//  SplashVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 16/02/25.
//

import UIKit

class SplashVC: UIViewController {
    let contentView: SplashView
    weak var flowDelegate: SplashFlowDelegate?

    init(contentView: SplashView, flowDelegate: SplashFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .mwlSurface
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)
        startBreathing()
    }
}

extension SplashVC {
    private func startBreathing() {
        UIView.animate(withDuration: 2.0, animations: { [weak self] in
            self?.contentView.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) {  [weak self] _ in
            self?.flowDelegate?.navigateToHome()
        }
    }
}

#Preview {
    SplashVC(contentView: SplashView())
}
