//
//  TokenPriceViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-13.
//

import UIKit
import ZKSync

class TokenPriceViewController: UIViewController, WalletConsumer {
    var wallet: Wallet!
    @IBOutlet weak var tokenPrice: UILabel!
    @IBOutlet weak var tokenPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getTokenPRice()
    }
    
    func getTokenPRice() {
        wallet.provider.tokenPrice(token: Token.ETH) { (result) in
            switch result {
            case .success(let price):
                self.tokenPriceLabel.text = "\(price)"
            case .failure(_):
                break
            }
        }
    }
}
