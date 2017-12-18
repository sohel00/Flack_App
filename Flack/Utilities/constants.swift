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



//User Defaults
let LOGGED_IN_KEY = "loggedIn"
let TOKEN_KEY = "token"
let USER_EMAIL = "userEmail"
