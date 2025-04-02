//
//  MWLDataLoadingVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 23/03/25.
//

import UIKit


class MWLDataLoadingVC: UIViewController {
    
    private var containerView: UIView!
    
    func showLoadingView(opacity: Double = 0.4){
        containerView = UIView(frame: view.bounds)
        

        let imageView = UIImageView()
        imageView.image = .mwlLogo
        
        view.addSubview(containerView)
        
        view.bringSubviewToFront(containerView)
        containerView.addBlurEffect(.dark)
    
        containerView.backgroundColor = .mwlSurface.withAlphaComponent(opacity)
      
        containerView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100)
        ])

        
        let scaleUp = CGAffineTransform(scaleX: 1.15, y: 1.15)
        let scaleDown = CGAffineTransform(scaleX: 1, y: 1)     
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.repeat]) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                imageView.transform = scaleUp
            }
  
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                imageView.transform = scaleDown
            }
        }
    }
    
    
    func dismissLoadingView(delay: Double = 0){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.animate(withDuration: 1){
                self.containerView.alpha = 0
            } completion: { _ in
                self.containerView.removeFromSuperview()
                self.containerView = nil
            }
        }
    }
    
}


#Preview {
    ProfileVC(contentView: ProfileView(), viewModel: ProfileViewModel())
}
