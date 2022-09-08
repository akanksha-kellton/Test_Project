//
//  StatusSql.swift
//  AKTest6
//
//  Created by IOS Training 2 on 22/08/22.
//

import Foundation
import UIKit

class StatusConstant {
    static let dbpathConstant = "StatusDBfile"
}

struct StatusSceneDelegateRefrence {
    static let sDelegate = (UIApplication.shared.connectedScenes.first!.delegate) as? SceneDelegate
}


struct StatusUserDefaultSavingKeys {
    static let isUserLogin = "isUserLogin"
    static let userEmailId = "emailId"
    static let isCoreDB = "isCoreDB"
}

enum StatusUserDefaultKeys: String {
    case id
    case userId
    case imageName
    case feed
    case feedId
    case type
}

