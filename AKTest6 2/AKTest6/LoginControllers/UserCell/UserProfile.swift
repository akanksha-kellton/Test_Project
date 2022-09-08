//
//  UserProfile.swift
//  AKTest6
//
//  Created by IOS Training 2 on 22/08/22.
//

import UIKit

class UserProfile: UITableViewCell {

    var delegate: UserProfileDelegate?
    @IBOutlet weak var setImage: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
    }
    
    @IBAction func setImageBtn(_ sender: UIButton) {
        self.delegate?.didSelectImage()
    }
}

protocol UserProfileDelegate{
    func didSelectImage()
}
