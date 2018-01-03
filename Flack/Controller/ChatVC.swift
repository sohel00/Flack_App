//
//  ChatVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 16/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var barTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDataDidChange(_:)), name: USER_DATA_DID_CHANGE, object: nil)
        
        if AuthService.instance.isLoggedIn{
            
            AuthService.instance.findUserByEmail(completion: { (success) in
                    NotificationCenter.default.post(name: USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
        
        
        
    }
    
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    func updateWithChannel(){
        let channelTitle = MessageService.instance.selectedChannel?.title ?? ""
        self.barTitle.text = "#\(channelTitle)"
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
           onLoginGetMesseges()
        } else {
            barTitle.text = "Please Log In"
        }
    }
    
    func onLoginGetMesseges(){
        MessageService.instance.findAllChannels { (success) in
            //
        }
    }

   

}
