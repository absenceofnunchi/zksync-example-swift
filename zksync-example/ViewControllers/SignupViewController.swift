//
//  SignupViewController.swift
//  zksync-example
//
//  Created by J on 2022-04-15.
//

/*
 Abstract:
 Sign up by generating a new private key or navigate to SigninVC to import an existing private key.
 */

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch sender.tag {
        case 0:
            print("create wallet")
        case 1:
            guard let vc = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.signinVC) as? SigninViewController else {
                return
            }
            present(vc, animated: true)
        default:
            break
        }
    }
    
    
}
