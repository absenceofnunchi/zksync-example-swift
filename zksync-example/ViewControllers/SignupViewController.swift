//
//  SignupViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-15.
//

/*
 Abstract:
 Sign up by generating a new private key or navigate to SigninVC to import an existing private key.
 */

import UIKit
import ZKSync

final class SignupViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    private var chainId: ChainId = .rinkeby
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch sender.tag {
        case 0:
            didCreateWallet()
        case 1:
            guard let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.signinVC) as? SigninViewController else {
                return
            }
            present(vc, animated: true)
        default:
            break
        }
    }
    
    private func didCreateWallet() {
        guard let password = passwordTextField.text else { return }
        
        
        let walletController = WalletGenerationController()
        walletController.createWallet(with: .createKey, password: password, key: nil) { [weak self] error in
            if let error = error {
                print(error)
            }
            
            guard let chainId = self?.chainId else {
                return
            }
            
            do {
                guard let privateKey = try KeysService().getWalletPrivateKey(password: password) else { return }
                let wallet = self?.createZKWallet(chainId, privateKey: privateKey)
                
            } catch {
                print(error)
            }
        }
    }
    
    private func createZKWallet(_ chainId: ChainId, privateKey: String) -> Wallet {
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

