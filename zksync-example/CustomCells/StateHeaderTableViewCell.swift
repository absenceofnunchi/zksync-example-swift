//
//  StateHeaderTableViewCell.swift
//  zksync-example
//
//  Created by J on 2022-04-10.
//

import UIKit

class StateSectionHeaderView: UITableViewHeaderFooterView {
    var nonceLabel = UILabel()
    var pubKeyHashLabel = UILabel()
    var nameLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        nonceLabel = UILabel()
        nonceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nonceLabel)
        
        pubKeyHashLabel = UILabel()
        pubKeyHashLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pubKeyHashLabel)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nonceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nonceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nonceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nonceLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            pubKeyHashLabel.topAnchor.constraint(equalTo: nonceLabel.bottomAnchor),
            pubKeyHashLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pubKeyHashLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pubKeyHashLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: pubKeyHashLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
}
