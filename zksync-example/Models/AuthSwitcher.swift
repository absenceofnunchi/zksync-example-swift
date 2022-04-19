//
//  AuthSwitcher.swift
//  zksync-example
//
//  Created by J on 2022-04-18.
//

import UIKit

class AuthSwitcher {
    static let userDefaults = UserDefaults.standard

    struct AuthDefaultsKey {
        static
    }
    
    static func updateRoot() {
        var rootViewController: UIViewController!

        guard let scene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = scene.delegate as? SceneDelegate,
              let windowScene = scene as? UIWindowScene else { return }

        sceneDelegate.window = UIWindow(windowScene: windowScene)
        sceneDelegate.window?.rootViewController = rootViewController
        sceneDelegate.window?.makeKeyAndVisible()
    }
}
