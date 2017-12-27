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
    
    var avatarname = "profileDefault"
    var avatarcolor = "[0.5,0.5,0.5,1]"

    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToChannelVC", sender: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarname = UserDataService.instance.avatarName
        }
    }
   
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = userTxt.text, userTxt.text != "" else {return}
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let pass = passTxt.text, passTxt.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("Registered user!")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (response) in
                    if response {
                        print(AuthService.instance.authToken)
                        AuthService.instance.addUser(name: name, email: email, avatarname: self.avatarname, avatarcolor: self.avatarcolor, completion: { (response) in
                            if response {
                               print(UserDataService.instance.name , UserDataService.instance.avatarName, UserDataService.instance.id, UserDataService.instance.email)
                                self.performSegue(withIdentifier: "unwindToChannelVC", sender: nil)
                            }
                        })
                    }
                })
            }
        }
        
    }
    
    @IBAction func chooseAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: "toAvatarPicker", sender: nil)
    }
    
    @IBAction func generateBgColorPressed(_ sender: Any) {
    }
    
    
    
    
    
}
