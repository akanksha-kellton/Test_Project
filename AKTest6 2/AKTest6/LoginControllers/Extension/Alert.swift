//
//  File.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showMessage(title: String) {
        let alert = UIAlertController(title: "Message", message: title, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
