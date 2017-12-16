//
//  CreateAccountVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 17/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToChannelVC", sender: nil)
    }
}
