//
//  constants.swift
//  Flack
//
//  Created by Sohel Dhengre on 18/12/17.
//  Copyright © 2017 Sohel Dengre. All rights reserved.
//

import Foundation

typealias completionHandler = (_ success: Bool) -> ()


//Url Constants
let BASE_URL = "https://flackapp.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"
let URL_GET_MESSAGES = "\(BASE_URL)message/byChannel/"

//notification
let USER_DATA_DID_CHANGE = Notification.Name("NotifUserDataChanged")
let USER_DATA_LOADED = Notification.Name("USERDATALOADED")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelselected")

//User Defaults
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"

//Header
let BEARER_HEADER =  [
    "content-type": "application/json; charset=utf-8",
    "Authorization": "Bearer \(AuthService.instance.authToken)"]







