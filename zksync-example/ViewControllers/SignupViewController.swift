//
//  SignupViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-15.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("create wallet")
        case 1:
            print("import wallet")
        default:
            break
        }
    }
    
    
}
