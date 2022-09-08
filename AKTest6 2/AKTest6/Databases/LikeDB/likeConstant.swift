//
//  LikeSql.swift
//  AKTest6
//
//  Created by IOS Training 2 on 22/08/22.
//

import Foundation
import UIKit

class LikeConstant {
    static let dbpathConstant = "LikeDBfile"
}

struct LikeSceneDelegateRefrence {
    static let sDelegate = (UIApplication.shared.connectedScenes.first!.delegate) as? SceneDelegate
}


struct LikeUserDefaultSavingKeys {
    static let isUserLogin = "isUserLogin"
    static let userEmailId = "emailId"
    static let isCoreDB = "isCoreDB"
}

enum LikeUserDefaultKeys: String {
    case userName
    case userId
    case imageName
    case feed
    case feedId
    case type
    
}

