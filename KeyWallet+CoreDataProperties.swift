//
//  KeyWallet+CoreDataProperties.swift
//  zksync-example
//
//  Created by J on 2022-04-16.
//
//

import Foundation
import CoreData


extension KeyWallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KeyWallet> {
        return NSFetchRequest<KeyWallet>(entityName: "KeyWallet")
    }

    @NSManaged public var address: String?
    @NSManaged public var data: Data?

}

extension KeyWallet : Identifiable {

}
