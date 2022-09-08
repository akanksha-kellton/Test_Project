//
//  RegisterCell.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//

import UIKit

class RegisterCell: UITableViewCell {

    var handler: ((_ type: Int) -> ())?
    
    @IBOutlet weak var register: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }
    
    @IBAction func newRegisterBtn(_ sender: UIButton) {
        handler?(1)
    }
}
