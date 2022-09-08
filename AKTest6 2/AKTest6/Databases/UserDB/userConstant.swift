//
//  userConstant.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//

import Foundation
import UIKit

class Constant {
    static let dbpathConstant = "DBfile"
}

struct SceneDelegateRefrence {
    static let sDelegate = (UIApplication.shared.connectedScenes.first!.delegate) as? SceneDelegate
    
}

public func getDirectory() -> URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
}

let loginEmailId = UserDefaults.standard.string(forKey: UserDefaultKeys.email.rawValue)!

enum UserDefaultKeys: String {
    case email
    case isLogin
}

class UserDefault{
    static func setData(email:String, isLogin:Bool){
        UserDefaults.standard.set(email, forKey: UserDefaultKeys.email.rawValue)
        UserDefaults.standard.set(isLogin, forKey: UserDefaultKeys.isLogin.rawValue)
    }
}
