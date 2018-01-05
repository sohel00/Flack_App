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
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message){
        self.userImg.image = UIImage(named: message.userAvatar)
        self.userNameLbl.text = message.userName
        self.messageBody.text = message.message
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        guard var isodate = message.timeStamp else {return}
        let end = isodate.index(isodate.endIndex, offsetBy: -5)
        isodate = isodate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isodate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = " h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
        dateLbl.text = finalDate
        }
    }
   

}
