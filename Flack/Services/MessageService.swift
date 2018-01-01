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
//                        print(self.channel[0].title)
                        completion(true)
                    }
                } catch {debugPrint(Error.self)}
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
}
