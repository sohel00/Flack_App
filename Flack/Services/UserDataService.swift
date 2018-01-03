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
    
    func returnUIColor (components:String) -> UIColor{
       let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r,g,b,a: NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        let defaultColor = UIColor.lightGray
        guard let rUnrapped = r else {return defaultColor}
        guard let gUnrapped = g else {return defaultColor}
        guard let bUnrapped = b else {return defaultColor}
        guard let aUnrapped = a else {return defaultColor}
        
        let rfloat = CGFloat(rUnrapped.doubleValue)
        let gfloat = CGFloat(gUnrapped.doubleValue)
        let bfloat = CGFloat(bUnrapped.doubleValue)
        let afloat = CGFloat(aUnrapped.doubleValue)
       
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        
        return newUIColor
    }
    
    func logOutUser(){
        id = ""
        email = ""
        name = ""
        avatarName = ""
        avatarColor = ""
        AuthService.instance.authToken = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        MessageService.instance.clearChannelData()
    }
    
    
    
    
    
}
