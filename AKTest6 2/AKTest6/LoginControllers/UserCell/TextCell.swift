//
//  TextCell.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//

import UIKit

class TextCell: UITableViewCell {

    @IBOutlet weak var emailfield: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none

        // Configure the view for the selected state
    }
    func updateRegisterUI(indexPath: IndexPath, userInfo: Userinfo, placeHolder: String) {
        self.emailfield.placeholder = placeHolder
        self.emailfield.text = ""
        self.emailfield.keyboardType = .default
        self.emailfield.isSecureTextEntry = false
        
        if indexPath.section == 0 {
            self.emailfield.tag = indexPath.row
            
            switch indexPath.row {
            case 1:
                self.emailfield.text = userInfo.Name
            case 2:
                self.emailfield.text = userInfo.EmailId
                self.emailfield.keyboardType = .emailAddress
            case 3:
                self.emailfield.text = userInfo.MobileNumber
            case 4:
                self.emailfield.text = userInfo.Password
                self.emailfield.isSecureTextEntry = true
            case 5:
                self.emailfield.text = userInfo.Confirmpassword
                self.emailfield.isSecureTextEntry = true
            default:
                self.emailfield.text = ""
            }
        } else {
            self.emailfield.tag = indexPath.row + 1000
            
            switch indexPath.row {
            case 0:
                
                self.emailfield.text = userInfo.Address
            case 1:
                self.emailfield.text = userInfo.State
            case 2:
                self.emailfield.text = userInfo.Pincode
            default:
                self.emailfield.text = ""
            }
        }
    }
    
}
