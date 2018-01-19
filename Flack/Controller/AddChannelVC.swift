//
//  AddChannelVC.swift
//  Flack
//
//  Created by Sohel Dhengre on 01/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {

    @IBOutlet weak var nameLbl: UITextField!
    @IBOutlet weak var descLbl: UITextField!
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpView()
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createChannelPressed(_ sender: Any) {
        guard let name = nameLbl.text, nameLbl.text != "" else {return}
        guard let desc = descLbl.text else {return}
        SocketService.instance.addChanel(name: name, description: desc) { (success) in
            if success{
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setUpView(){
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(self.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
