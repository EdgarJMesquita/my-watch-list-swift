//
//  SceneDelegate.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 16/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var flowController: MWLFlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        flowController = MWLFlowCoordinator()

        let rootViewController = flowController?.start()

        window.rootViewController = rootViewController
        self.window = window
        window.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        
//        do {
//            guard
//                let url = URLContexts.first?.url,
//                let params = url.getQueryparams()
//            else {
//                throw MWLError.invalidURL
//            }
//            
//            guard
//                params["approved"] == "true",
//                let requestToken = params["request_token"]
//            else {
//                throw MWLError.invalidURL
//            }
//            
//            Task {
//                do {
//                    try await AuthService.fetchSessionId(requestToken: requestToken)
//                    let accountDetails = try await AuthService().getAccountDetails()
//                    let username = accountDetails.name.isEmpty ? accountDetails.username : accountDetails.name
//                    
//                    flowController?.presentLoginSuccess(username: username ?? "My friend")
//                    
//                } catch {
//                    flowController?.presentLoginFailure()
//                    print(error.localizedDescription)
//                }
//            }
//            
//        } catch {
//            flowController?.presentLoginFailure()
//            print(error.localizedDescription)
//        }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
