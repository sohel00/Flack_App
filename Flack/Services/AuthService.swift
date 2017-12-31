//
//  AuthService.swift
//  Flack
//
//  Created by Sohel Dhengre on 18/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool {
        get {
        return defaults.bool(forKey: LOGGED_IN_KEY)
        } set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
    }
}
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        } set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    
    var userEmail :String{
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        } set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email:String, password: String, completion: @escaping completionHandler)  {
        let lowerCaseEmail = email.lowercased()
        let header = [
            "content-type": "application/json; charset=utf-8"]
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
       
        Alamofire.request(URL_REGISTER, method: .post, parameters: body , encoding: JSONEncoding.default , headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password:String, completion: @escaping completionHandler){
       let lowerCaseEmail = email.lowercased()
        let header = [
            "content-type": "application/json; charset=utf-8"]
        let body: [String:Any] = [
            "email": lowerCaseEmail,
            "password": password]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                
                // parsing JSON using SwiftyJSON
                guard let data = response.data else {return}
                do {
                let json = try JSON(data: data)
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                } catch {debugPrint(error)}
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func addUser(name:String, email:String, avatarname:String, avatarcolor:String, completion: @escaping completionHandler){
        let lowerCaseEmail = email.lowercased()
        
       
        
        let body:[String: Any] = [
            "name" : name,
            "email" : lowerCaseEmail,
            "avatarName": avatarname,
            "avatarColor" : avatarcolor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                //JSON parsing using SwiftyJSON
                guard let data = response.data else {return}
                do{
                    let json = try JSON(data: data)
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                    let avatarname = json["avatarName"].stringValue
                    let avatarcolor = json["avatarColor"].stringValue
                    let id = json["_id"].stringValue
                    
                    UserDataService.instance.userData(name: name, email: email, avatarName: avatarname, avatarColor: avatarcolor, id: id)
                } catch{debugPrint(error)}
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion:@escaping completionHandler){
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            guard let data = response.data else {return}
            do{
                let json = try JSON(data: data)
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                let avatarname = json["avatarName"].stringValue
                let avatarcolor = json["avatarColor"].stringValue
                let id = json["_id"].stringValue
                
                UserDataService.instance.userData(name: name, email: email, avatarName: avatarname, avatarColor: avatarcolor, id: id)
            } catch{debugPrint(error)}
            completion(true)
        }
    }
    

    
    

    
}
