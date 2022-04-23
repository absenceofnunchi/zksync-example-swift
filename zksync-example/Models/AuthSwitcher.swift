//
//  AuthSwitcher.swift
//  zksync-example
//
//  Created by J on 2022-04-18.
//

import UIKit
import ZKSync

class AuthSwitcher {
    static let shared = AuthSwitcher()
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
        do {
            if let privateKey = try KeysService().getWalletPrivateKey(password: password) {
                let wallet = createZKWallet(.rinkeby, privateKey: privateKey)
                print("wallet", wallet as Any)
            }
            
            
            
        } catch {
            print(error)
        }
        
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
    
    static func createZKWallet(_ chainId: ChainId, privateKey: String) -> Wallet {
        guard let ethSigner = try? DefaultEthSigner(privateKey: privateKey) else {
            fatalError()
        }

        guard let zkSigner = try? ZkSigner(ethSigner: ethSigner, chainId: chainId) else {
            fatalError()
        }

        let provider = DefaultProvider(chainId: chainId)

        guard let wallet = try? DefaultWallet(ethSigner: ethSigner, zkSigner: zkSigner, provider: provider) else {
            fatalError()
        }

        return wallet
    }
    
}
