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
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.delegate = self
        tableview.dataSource = self
        self.revealViewController().rearViewRevealWidth = view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDataDidChange), name: USER_DATA_DID_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpUserData()
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
            return ChannelCell()
    }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func unwindToChannelVC(a: UIStoryboardSegue){}
    

}
