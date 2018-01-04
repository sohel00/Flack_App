//
//  MessageCell.swift
//  Flack
//
//  Created by Sohel Dhengre on 04/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //outlets
    
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message){
        self.userImg.image = UIImage(named: message.userAvatar)
        self.userNameLbl.text = message.userName
        self.messageBody.text = message.message
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
   

}
