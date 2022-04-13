//
//  MethodSelectionViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-12.
//

import UIKit

class MethodSelectionViewController: UIViewController {
    private var tableView: UITableView!
    private var stackView: UIStackView!
    private let dataSource: [Any] = [
        ["Address", "ZkSync Balance", "ETH Balance"],
        "Get Contract Address",
        "Get Account Info",
        "Get Token Price",
        "Get Transaction Fee",
        "Deposit",
        "Withdraw",
        "Transfer"
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
    }
    
    private func setConstraints() {
        
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
            cell.zksyncBalance.text = data[1]
            cell.ethBalance.text = data[2]
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
    
}

class BalanceAddressCell: UITableViewCell {
    static let identifier = "BalanceAddressCell"
    var addressLabel: UILabel!
    var zksyncBalance: UILabel!
    var ethBalance: UILabel!
    let inset: CGFloat = 10
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        setConstraints()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addressLabel = createLabel(text: "Address")
        contentView.addSubview(addressLabel)
        
        zksyncBalance = createLabel(text: "ZkSync Balance")
        contentView.addSubview(zksyncBalance)
        
        ethBalance = createLabel(text: "ETH Balance")
        contentView.addSubview(ethBalance)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            addressLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            zksyncBalance.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            zksyncBalance.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            zksyncBalance.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            zksyncBalance.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            ethBalance.topAnchor.constraint(equalTo: zksyncBalance.bottomAnchor),
            ethBalance.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            ethBalance.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            ethBalance.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
    
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
