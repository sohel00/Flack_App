//
//  ChannelVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 16/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = view.frame.size.width - 60
    }

    

}
