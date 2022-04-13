//
//  NetworkSelectionTableViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-12.
//

import UIKit
import ZKSync
import ZKSyncCrypto

class NetworkSelectionTableViewController: UITableViewController {

    var privateKey = "0xeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        var chainId: ChainId = .localhost
        switch segue.identifier {
        case "MainnetSegue":
            chainId = .mainnet
        case "RinkebySegue":
            chainId = .rinkeby
        case "RopsteinSegue":
            chainId = .ropsten
        default:
            break
        }
        if var destination = segue.destination as? WalletConsumer {
            destination.wallet = createWallet(chainId)
        }
    }

    private func createWallet(_ chainId: ChainId) -> Wallet {
        guard let ethSigner = try? DefaultEthSigner(privateKey: self.privateKey) else {
            fatalError()
        }

//        var message = "Access zkSync account.\n\nOnly sign this message for a trusted client!"
//        let signature = try? ethSigner.sign(message: message.data(using: .utf8)!),
//        if chainId != .mainnet {
//            message = "\(message)\nChain ID: \(chainId.id)."
//        }

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
