//
//  MethodSelectionViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-12.
//

import UIKit
import ZKSync
import web3swift
import PromiseKit

enum Menu: String {
    case getContractAddress = "Get Contract Address"
    case getAccountInfo = "Get Account Info"
    case getTokenPrice = "Get Token Price"
    case getTransactionFee = "Get Transaction Fee"
    case deposit = "Deposit"
    case withdraw = "Withdraw"
    case transfer = "Transfer"
}

class MethodSelectionViewController: UIViewController, WalletConsumer {
    var wallet: Wallet!
    private var tableView: UITableView!
    private var stackView: UIStackView!
    private let dataSource: [Any] = [
        ["Address", "ZkSync Balance", "ETH Balance"],
        Menu.getContractAddress.rawValue,
        Menu.getAccountInfo.rawValue,
        Menu.getTokenPrice.rawValue,
        Menu.getTransactionFee.rawValue,
        Menu.deposit.rawValue,
        Menu.withdraw.rawValue,
        Menu.transfer.rawValue
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentSize = CGSize(width: view.bounds.width, height: Double(dataSource.count * 60))
    }
    
    private func configureUI() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(BalanceAddressCell.self, forCellReuseIdentifier: BalanceAddressCell.identifier)
        view.addSubview(tableView)
        tableView.setFill()
        
        self.wallet.getAccountState { (result) in
            self.updateBalances(state: try? result.get())
        }
    }
    
    private func setConstraints() {
        
    }

    private func weiToETH(string: String) -> String? {
        guard let value = Web3.Utils.parseToBigUInt(string, units: .wei) else {
            return nil
        }
        return Web3.Utils.formatToEthereumUnits(value)
    }

    private func updateBalances(state: AccountState?) {
        guard let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? BalanceAddressCell else { return }
        cell.addressLabel.text = state?.address
        cell.zksyncBalanceLabel.text = weiToETH(string: state?.committed.balances["ETH"] ?? "0")
        let provider = try? self.wallet.createEthereumProvider(web3: Web3.InfuraRinkebyWeb3())
        provider?.getBalance().done { (value) in
            cell.ethBalanceLabel.text = Web3.Utils.formatToEthereumUnits(value)
        }.catch { (error) in
            self.present(UIAlertController.for(error: error), animated: true, completion: nil)
        }
    }
}

extension MethodSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BalanceAddressCell.identifier, for: indexPath) as? BalanceAddressCell,
                  let data = dataSource[indexPath.row] as? [String] else {
                fatalError()
            }
            
            cell.addressLabel.text = data[0]
            cell.zksyncBalanceLabel.text = data[1]
            cell.ethBalanceLabel.text = data[2]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            guard let data = dataSource[indexPath.row] as? String else {
                fatalError()
            }
                    
            cell.textLabel?.text = data
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case 0:
                return 150
            default:
                return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = dataSource[indexPath.row] as? String,
              let menu = Menu(rawValue: data) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        switch menu {
        case .getContractAddress:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "ContractAddressViewController") as? ContractAddressViewController else { return }
            vc.wallet = wallet
            self.navigationController?.pushViewController(vc, animated: true)
        case .getAccountInfo:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "AccountStateViewController") as? AccountStateViewController else { return }
            vc.wallet = wallet
            self.navigationController?.pushViewController(vc, animated: true)
        case .getTokenPrice:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "TokenPriceViewController") as? TokenPriceViewController else { return }
            vc.wallet = wallet
            self.navigationController?.pushViewController(vc, animated: true)
        case .getTransactionFee:
            guard let vc = storyboard.instantiateViewController(withIdentifier: "TransactionFeeViewController") as? TransactionFeeViewController else { return }
            vc.wallet = wallet
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}
