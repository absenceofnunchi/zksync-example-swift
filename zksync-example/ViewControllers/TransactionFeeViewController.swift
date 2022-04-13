//
//  TransactionFeeViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-13.
//

import UIKit
import ZKSync

class TransactionFeeViewController: UIViewController, WalletConsumer {
    var wallet: Wallet!
    @IBOutlet weak var gasTxLabel: UILabel!
    @IBOutlet weak var gasPriceWeiLabel: UILabel!
    @IBOutlet weak var gasFeeLabel: UILabel!
    @IBOutlet weak var zkpFeeLabel: UILabel!
    @IBOutlet weak var totalFeeLabel: UILabel!
    
    @IBAction func fastWithdraw(_ sender: Any) {
        wallet.provider.transactionFee(for: .fastWithdraw,
                                       address: wallet.address,
                                       tokenIdentifier: Token.ETH.address) { (result) in
            self.title = "Fast Withdraw"
            self.processResult(result)
        }
    }
    
    @IBAction func withdraw(_ sender: Any) {
        wallet.provider.transactionFee(for: .withdraw,
                                       address: wallet.address,
                                       tokenIdentifier: Token.ETH.address) { (result) in
            self.title = "Withdraw"
            self.processResult(result)
        }
    }
    
    @IBAction func forcedExit(_ sender: Any) {
        wallet.provider.transactionFee(for: .forcedExit,
                                       address: wallet.address,
                                       tokenIdentifier: Token.ETH.address) { (result) in
            self.title = "Forced Exit"
            self.processResult(result)
        }
    }
    
    @IBAction func changePubKey(_ sender: Any) {
//        wallet.provider.transactionFee(for: .legacyChangePubKey,
//                                       address: wallet.address,
//                                       tokenIdentifier: Token.ETH.address) { (result) in
//            self.title = "Change Pub Key"
//            self.processResult(result)
//        }
    }
    
    @IBAction func changePubKeyOnchainAuth(_ sender: Any) {
        wallet.provider.transactionFee(for: .fastWithdraw,
                                       address: wallet.address,
                                       tokenIdentifier: Token.ETH.address) { (result) in
            self.title = "Change Pub Key Onchain Auth"
            self.processResult(result)
        }
    }
    
    @IBAction func transfer(_ sender: Any) {
        wallet.provider.transactionFee(for: .transfer,
                                       address: "0x4F6071Dbd5818473EEEF6CE563e66bf22618d8c0".lowercased(),
                                       tokenIdentifier: Token.ETH.address) { (result) in
            self.title = "Transfer"
            self.processResult(result)
        }
    }
    
    func processResult(_ result: ZKSyncResult<TransactionFeeDetails>) {
        switch result {
        case .success(let feeDetails):
            gasTxLabel.text = feeDetails.gasTxAmount
            gasPriceWeiLabel.text = feeDetails.gasPriceWei
            gasFeeLabel.text = feeDetails.gasFee
            zkpFeeLabel.text = feeDetails.zkpFee
            totalFeeLabel.text = feeDetails.totalFee
        default:
            break
        }
    }
}
