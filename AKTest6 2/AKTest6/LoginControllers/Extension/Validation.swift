//
//  Validation.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//

import Foundation
extension String {
    func validateEmailId() -> Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
    }
}
