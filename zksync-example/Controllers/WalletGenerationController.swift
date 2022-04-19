//
//  WalletGenerationController.swift
//  zksync-example
//
//  Created by J on 2022-04-18.
//

import Foundation
import web3swift

class WalletGenerationController {
    let localStorage = LocalDatabase()
    let keysService: KeysService = KeysService()
    let web3Service: Web3swiftService = Web3swiftService()
}

enum WalletCreationType {
    case .createKey
    case .importKey
}

extension WalletGenerationController {
    func createWallet(with mode: WalletCreationType, password: String?, key: String?, completion: @escaping (Errors?) -> Void) {
        guard let password = password else {
            completion(.generalError("No passwword provided"))
            return
        }
        
        switch mode {
            case .createKey:
                keysService.createNewWallet(password: password) { (wallet, error) in
                    if let error = error {
                        completion(error)
                    } else {
                        guard let wallet = wallet else {
                            return
                        }
                        
                        self.localStorage.saveWallet(isRegistered: false, wallet: wallet) { (error) in
                            completion(error)
                        }
                    }
                }
            case .importKey:
                guard let key = key else {
                    completion(.generalError("No key provided"))
                    return
                }
                
                keysService.addNewWalletWithPrivateKey(key: key, password: password) { (wallet, error) in
                    if let error = error {
                        completion(error)
                    } else {
                        //                        guard let address = wallet?.address, let walletAddress = EthereumAddress(address) else {
                        //                            completion(error)
                        //                            return
                        //                        }
                        
                        self.localStorage.saveWallet(isRegistered: true, wallet: wallet!) { (error) in
                            completion(error)
                        }
                    }
                }
        }
    }
}
