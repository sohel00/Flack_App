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
    var bgColor: UIColor?

    @IBOutlet weak var userTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToChannelVC", sender: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarname = UserDataService.instance.avatarName
            if avatarname.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
   
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
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
                              self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: "unwindToChannelVC", sender: nil)
                        NotificationCenter.default.post(name: USER_DATA_DID_CHANGE , object: nil)
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
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarcolor = "[\(r), \(g), \(b), \(1)]"
        UIView.animate(withDuration: 0.2){
        self.userImg.backgroundColor = self.bgColor
        }
    }
    
    

    
    
}
