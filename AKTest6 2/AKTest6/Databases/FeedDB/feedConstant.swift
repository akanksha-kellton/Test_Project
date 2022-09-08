//
//  FeedSql.swift
//  AKTest6
//
//  Created by IOS Training 2 on 22/08/22.
//

import Foundation
import UIKit

class FeedConstant {
    static let dbpathConstant = "FeedDBfile"
}

struct FeedSceneDelegateRefrence {
    static let sDelegate = (UIApplication.shared.connectedScenes.first!.delegate) as? SceneDelegate
}


struct FeedUserDefaultSavingKeys {
    static let isUserLogin = "id"
    static let isuserId = "userId"
//    static let isUserFeed = "feedImage"
//    static let isCoreDB = "isCoreDB"
}

enum FeedUserDefaultKeys: String {
    case id
    case userId
//    case feedImage
//    case feed

}

