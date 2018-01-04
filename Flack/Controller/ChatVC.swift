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
    @IBOutlet weak var message: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
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
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message  = message.text else {return}
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success{
                    self.message.text = ""
                    self.message.resignFirstResponder()
                }
            })
        }
    }
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    func updateWithChannel(){
        let channelTitle = MessageService.instance.selectedChannel?.title ?? ""
        self.barTitle.text = "#\(channelTitle)"
        getMesssages()
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
            if MessageService.instance.channel.count > 0{
                MessageService.instance.selectedChannel = MessageService.instance.channel[0]
                self.updateWithChannel()
            } else {
                self.barTitle.text = "No Channels Yet!"
            }
        }
    }
    
    func getMesssages(){
        guard let channelid = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessages(id: channelid) { (success) in
        
        }
    }

   

}
