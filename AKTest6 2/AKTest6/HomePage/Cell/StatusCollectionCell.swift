//
//  StatusCollectionCell.swift
//  AssignmentFive
//
//  Created by IOS Training 2 on 12/08/22.
//

import UIKit

class StatusCollectionCell: UICollectionViewCell {
    
    var didSelectRow: ((_ data: String) -> Void)? = nil
    var passeddata = String()
    var handler: ((_ type: Int) -> ())?
   
    
    @IBOutlet weak var statusImg: UIImageView!
    static let identifier = "StatusCollectionCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "StatusCollectionCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        statusImg.image = UIImage(named: passeddata)
    }
    
    public func config(with model: Statusinfo) {
        self.statusImg.image = UIImage(named: model.statusImage)
    }

}
