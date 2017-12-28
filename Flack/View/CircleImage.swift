//
//  CircleImage.swift
//  Flack
//
//  Created by Sohel Dhengre on 28/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import UIKit
@IBDesignable

class CircleImage: UIImageView {

    override func awakeFromNib() {
        
        setUpView()
    }

    
    func setUpView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
}
