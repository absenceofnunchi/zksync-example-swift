//
//  ContractAddressViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-13.
//

import UIKit
import ZKSync

class ContractAddressViewController: UIViewController, WalletConsumer {
    var wallet: Wallet!
    @IBOutlet weak var mainContractLabel: UILabel!
    @IBOutlet weak var govContractLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    @IBAction func getContractAddress(_ sender: UIButton) {
        self.wallet.provider.contractAddress { result in
            switch result {
            case .success(let address):
                self.display(contractAddress: address)
            case .failure(let error):
                self.display(error: error)
            }
        }
    }
    
    private func display(contractAddress: ContractAddress) {
        self.mainContractLabel.text = contractAddress.mainContract
        self.govContractLabel.text = contractAddress.govContract
    }

    private func display(error: Error) {

    }
}
