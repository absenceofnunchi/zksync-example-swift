//
//  AppProtocolType.swift
//  zksync-example
//
//  Created by J on 2022-04-10.
//

import Foundation
import ZKSync

protocol WalletConsumer {
    var wallet: Wallet! { get set }
}
