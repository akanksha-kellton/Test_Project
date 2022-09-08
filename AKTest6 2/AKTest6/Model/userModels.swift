//
//  statusData.swift
//  AKTest6
//
//  Created by IOS Training 2 on 22/08/22.
//

import Foundation
import UIKit

//MARK: - User Model
struct Userinfo {
    var Name: String = ""
    var EmailId: String = ""
    var MobileNumber: String = ""
    var Password: String = ""
    var Confirmpassword: String = ""
    var Address: String = ""
    var State: String = ""
    var Pincode: String = ""
   
    var isCoredataBase: Bool = false
}

//MARK: - Status Model

struct Statusinfo {
    var id: String = ""
    var userId: String = ""
    var statusImage: String = ""
    var timer: String = ""
    var isCoredataBase1: Bool = false
    
}

//MARK: - Feed Model

struct Feedinfo {
    var id : Int?
    var userId: String = ""
    var feedImage: String = ""
    var feed: String = ""
    var isCoredataBase2: Bool = false
}

//MARK: - Like Model

struct Likeinfo {
    var id: String = ""
    var feedId: String = ""
    var userId: String = ""
    var isCoredataBase3: Bool = false
}
