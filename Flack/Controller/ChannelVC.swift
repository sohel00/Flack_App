//
//  ChannelVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 16/12/17.
//  Copyright © 2017 Sohel Dhengre. All rights reserved.


import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var tableview: UITableView!
    
    @IBAction func addChannelPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let addChannel = AddChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        self.revealViewController().rearViewRevealWidth = view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDataDidChange), name: USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDataLoad), name: USER_DATA_LOADED, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableview.reloadData()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserData()
    }
    override func viewWillAppear(_ animated: Bool) {
        setUpUserData()
    }
    
    @objc func userDataLoad(){
        tableview.reloadData()
    }
    
    @objc func userDataDidChange(){
        setUpUserData()
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
        if AuthService.instance.isLoggedIn{
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
        performSegue(withIdentifier: "toLogin", sender: nil)
        }
    }
    
    func setUpUserData(){
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            self.tableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
        let channel = MessageService.instance.channel[indexPath.row]
            cell.configureCell(channel: channel)
        
        return cell
        } else {
            return UITableViewCell()
    }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channel[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController().revealToggle(animated: true)
    }
    
    @IBAction func unwindToChannelVC(a: UIStoryboardSegue){}
    

}
////jkdsfkjshdf
