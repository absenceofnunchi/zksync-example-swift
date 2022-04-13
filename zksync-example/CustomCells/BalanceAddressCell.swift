//
//  BalanceAddressCell.swift
//  zksync-example
//
//  Created by J on 2022-04-13.
//

import UIKit

class BalanceAddressCell: UITableViewCell {
    static let identifier = "BalanceAddressCell"
    var addressLabel: UILabel!
    var zksyncBalanceLabel: UILabel!
    var ethBalanceLabel: UILabel!
    let inset: CGFloat = 20
    
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
        
        zksyncBalanceLabel = createLabel(text: "ZkSync Balance")
        contentView.addSubview(zksyncBalanceLabel)
        
        ethBalanceLabel = createLabel(text: "ETH Balance")
        contentView.addSubview(ethBalanceLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            addressLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            zksyncBalanceLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
            zksyncBalanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            zksyncBalanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            zksyncBalanceLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            ethBalanceLabel.topAnchor.constraint(equalTo: zksyncBalanceLabel.bottomAnchor),
            ethBalanceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            ethBalanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            ethBalanceLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
    
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
