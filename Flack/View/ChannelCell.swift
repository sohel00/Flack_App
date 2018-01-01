//
//  ChannelCell.swift
//  Flack
//
//  Created by Sohel Dhengre on 01/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configureCell(channel: Channel){
        let title = channel.title
        self.channelName.text = "#\(title)"
    }
    
    
}
