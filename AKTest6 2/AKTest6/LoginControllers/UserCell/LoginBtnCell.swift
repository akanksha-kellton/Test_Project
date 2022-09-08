//
//  LoginBtnCell.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//

import UIKit

class LoginBtnCell: UITableViewCell {

    @IBOutlet weak var submitOutlet: UIButton!
    @IBOutlet weak var registerOutlet: UIButton!
    var handler: ((_ type: Int) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }
    
    @IBAction func NewBtn(_ sender: UIButton) {
        handler?(1)
    }
    @IBAction func SubmitBtn(_ sender: UIButton) {
        handler?(2)
    }
}
