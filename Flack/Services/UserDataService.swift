//
//  UserDataService.swift
//  Flack
//
//  Created by Sohel Dhengre on 20/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import Foundation


class UserDataService {
    static let instance = UserDataService()
    public private(set) var id = ""
    public private(set) var name = ""
    public private(set) var email = ""
    public private(set) var avatarName = ""
    public private(set) var avatarColor = ""
    
    
    func userData (name:String, email:String, avatarName:String,
                   avatarColor:String, id: String) {
        self.name = name
        self.email = email
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.id = id
    }
    
    func setAvatarName (avatarname :String){
        self.avatarName = avatarname
    }
    
}
