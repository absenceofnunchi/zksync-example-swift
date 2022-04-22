//
//  AuthSwitcher.swift
//  zksync-example
//
//  Created by J on 2022-04-18.
//

import UIKit
import ZKSync

class AuthSwitcher {
    static let localDatabase = LocalDatabase()

    struct AuthDefaultsKey {
        static let isLoggedIn = "isLoggedIn"
    }
    
    static func updateRoot() {
        var rootViewController: UIViewController!

        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene.delegate as? SceneDelegate,
              let windowScene = scene as? UIWindowScene else { return }

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let wallet = localDatabase.getWallet() {
            guard let tabBarController = storyboard.instantiateViewController(withIdentifier: ViewControllerNames.MainTabBarController) as? UITabBarController,
                  let viewControllers = tabBarController.viewControllers else { return }

            for case let vc as AssetsViewController in viewControllers {
//                vc.wallet = wallet
            }
            rootViewController = tabBarController
        } else {
            rootViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerNames.SignupViewController)
        }
        
        sceneDelegate.window = UIWindow(windowScene: windowScene)
        sceneDelegate.window?.rootViewController = rootViewController
        sceneDelegate.window?.makeKeyAndVisible()
    }
    
    static func signin(_ wallet: Wallet) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: ViewControllerNames.MainTabBarController) as? UITabBarController,
              let viewControllers = tabBarController.viewControllers else { return }

        for case let vc as AssetsViewController in viewControllers {
            vc.wallet = wallet
        }
        
        updateRoot()
    }
}
