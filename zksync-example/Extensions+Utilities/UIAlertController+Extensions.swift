//
//  UIAlertController+Extensions.swift
//  zksync-example
//
//  Created by J on 2022-04-13.
//

import Foundation
import UIKit

extension UIAlertController {
    static func `for`(error: Error) -> UIAlertController {
        let alert = UIAlertController(title: "Error",
                                      message: (error as NSError).localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }

    static func `for`(message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }

    static func forIncorrectAmount() -> UIAlertController {
        let alert = UIAlertController(title: "Error",
                                      message: "Incorrect amount",
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        return alert
    }

    static func forIncorrectAddress() -> UIAlertController {
        let alert = UIAlertController(title: "Error",
                                      message: "Incorrect address",
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}
