//
//  MessageService.swift
//  Flack
//
//  Created by Sohel Dhengre on 01/01/18.
//  Copyright © 2018 Sohel Dengre. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService{
    
    static let instance = MessageService()
    
    var channel = [Channel]()
    var selectedChannel: Channel?
    var message = [Message]()
    
    func findAllChannels(completion: @escaping completionHandler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                do {
                    if let json = try JSON(data: data).array {
                        for item in json{
                            let name = item["name"].stringValue
                            let desc = item["description"].stringValue
                            let id = item["_id"].stringValue
                            
                            let channel = Channel(title: name, desc: desc, id: id)
                            self.channel.append(channel)
                        }
                        NotificationCenter.default.post(name: USER_DATA_LOADED, object: nil)
                        completion(true)
                    }
                } catch {debugPrint(Error.self)}
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessages(id: String, completion: @escaping completionHandler){
        Alamofire.request("\(URL_GET_MESSAGES)\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                do{
                    if let json = try JSON(data: data).array{
                    for item in json{
                        let messageBody = item["messageBody"].stringValue
                        let channelId = item["channelId"].stringValue
                        let id = item["_id"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        let userName = item["userName"].stringValue
                        
                        let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                       self.message.append(message)
                        }
                        //print message
                        completion(true)
                    }} catch{debugPrint(error)}
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func clearMessages(){
        self.message.removeAll()
    }
    
    func clearChannelData(){
        self.channel.removeAll()
    }
}









