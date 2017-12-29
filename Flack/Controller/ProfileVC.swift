//
//  ProfileVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 29/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    //outlets
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

   
    
    @IBAction func closePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutpressed(_ sender: Any) {
        UserDataService.instance.logOutUser()
        NotificationCenter.default.post(name: USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setUpView(){
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
    
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
