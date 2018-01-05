//
//  ChatVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 16/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    //outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var barTitle: UILabel!
    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var sendMessageBtn: UIButton!
    @IBOutlet weak var typingLbl: UILabel!
    var isTyping = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        message.layer.cornerRadius = 12
        tableview.delegate = self
        tableview.dataSource = self
        tableview.estimatedRowHeight = 80
        tableview.rowHeight = UITableViewAutomaticDimension
        sendMessageBtn.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        view.addGestureRecognizer(tap)
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDataDidChange(_:)), name: USER_DATA_DID_CHANGE, object: nil)
        
        SocketService.instance.getChatMessages { (success) in
            if success {
                self.tableview.reloadData()
                if MessageService.instance.message.count > 0 {
                    let index = IndexPath(row: MessageService.instance.message.count-1, section: 0)
                    self.tableview.scrollToRow(at: index, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channelId == channel {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
            }
        }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingLbl.text = "\(names) \(verb) typing a message"
            } else {
                self.typingLbl.text = ""
            }
        }
        
        if AuthService.instance.isLoggedIn{
            
            AuthService.instance.findUserByEmail(completion: { (success) in
                    NotificationCenter.default.post(name: USER_DATA_DID_CHANGE, object: nil)
            })
        }
        
        
        
        
    }
    
    @IBAction func editing(_ sender: Any) {
       guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        if message.text == "" {
            isTyping = false
            sendMessageBtn.isHidden = true
            SocketService.instance.manager.defaultSocket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
            sendMessageBtn.isHidden = false
              SocketService.instance.manager.defaultSocket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
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
                 SocketService.instance.manager.defaultSocket.emit("stopType", UserDataService.instance.name, channelId)
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
            self.tableview.reloadData()
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
        self.tableview.reloadData()
        }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return MessageService.instance.message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.message[indexPath.row]
            cell.configureCell(message: message)
        return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   

}
