//
//  ImageShape.swift
//  AKTest6
//
//  Created by IOS Training 2 on 24/08/22.
//

import UIKit
extension UIImageView {
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
