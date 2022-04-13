//
//  DepositingBalanceTableViewCell.swift
//  zksync-example
//
//  Created by J on 2022-04-10.
//

import UIKit

final class DepositingBalanceTableViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var amountLabel: UILabel!
    var blockNumber: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func configure() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        amountLabel = UILabel()
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(amountLabel)
        
        blockNumber = UILabel()
        blockNumber.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blockNumber)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            amountLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            amountLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            blockNumber.topAnchor.constraint(equalTo: amountLabel.bottomAnchor),
            blockNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blockNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blockNumber.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
}
