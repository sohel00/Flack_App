//
//  RoundedButton.swift
//  Flack
//
//  Created by Sohel Dhengre on 18/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView(){
        self.layer.cornerRadius = cornerRadius
    }

}
