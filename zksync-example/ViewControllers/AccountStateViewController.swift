//
//  AccountStateViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-10.
//

import UIKit
import ZKSync
import ZKSyncCrypto

final class AccountStateViewController: UIViewController, WalletConsumer {
    internal var wallet: Wallet!
    private var accountState: AccountState!
    private var tableView: UITableView!
    private var addressLabel: UILabel!
    private var idLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
    }

    private func configureUI() {
        title = "Account State"
        
        addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressLabel)
        
        idLabel = UILabel()
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(idLabel)
        
        tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionHeaderHeight = 60
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BalanceCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Depositing")
        tableView.register(StateSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "StateHeader")
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: view.topAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            addressLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            addressLabel.heightAnchor.constraint(equalToConstant: 50),
            
            idLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            idLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            idLabel.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func getAccountState(_ sender: Any) {
        wallet.getAccountState { (result) in
            switch result {
            case .success(let state):
                self.update(state: state)
            case .failure(_):
                break
            }
        }
    }

    private func update(state: AccountState) {
        self.accountState = state
        self.tableView.reloadData()
        self.addressLabel.text = "Address: " + state.address
        self.idLabel.text = "ID: \(state.id ?? 0)"
    }
}

extension AccountStateViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return accountState != nil ? 3 : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.accountState?.committed.balances.count ?? 0
        case 1:
            return self.accountState?.verified.balances.count ?? 0
        case 2:
            return self.accountState?.depositing.balances.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0, 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceCell")
                ?? UITableViewCell.init(style: .subtitle, reuseIdentifier: "BalanceCell")
            let balances = indexPath.section == 0
                ? self.accountState!.committed.balances
                : self.accountState!.verified.balances
            let key = Array(balances)[indexPath.row].key
            cell.textLabel?.text = key
            cell.detailTextLabel?.text = balances[key]
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Depositing",
                                                           for: indexPath) as? DepositingBalanceTableViewCell else {
                return UITableViewCell()
            }
            let balances = self.accountState!.depositing.balances
            let key = Array(balances)[indexPath.row].key
            let balance = balances[key]!
            cell.titleLabel.text = key
            cell.amountLabel.text = "Amount: " + balance.amount
            cell.blockNumber.text = "Block number: \(balance.expectedAcceptBlock)"
            return cell
        default:
            break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0, 1:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "StateHeader") as? StateSectionHeaderView
            let state = section == 0 ? self.accountState?.committed : accountState?.verified
            headerView?.nonceLabel.text = "\(state?.nonce ?? 0)"
            headerView?.pubKeyHashLabel.text = state?.pubKeyHash
            headerView?.nameLabel.text = section == 0 ? "Committed" : "Verified"
            return headerView
        case 2:
            let label = UILabel()
            label.textColor = .black
            label.text = "Depositing"
            label.textAlignment = .center
            return label
        default:
            break
        }
        return nil
    }
}
