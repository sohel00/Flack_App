//
//  CreateAccountVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 17/12/17.
//  Copyright © 2017 Sohel Dhengre. All rights reserved.
//

import UIKit
import Alamofire

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToChannelVC", sender: nil)
    }
    
    
    
   
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let pass = passTxt.text, passTxt.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("Registered user!")
            }
        }
        
    }
    
    
    
    
    
    
    
}
