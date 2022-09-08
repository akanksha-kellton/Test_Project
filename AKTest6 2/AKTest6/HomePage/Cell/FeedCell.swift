//
//  FeedCell.swift
//  AssignmentFive
//
//  Created by IOS Training 2 on 11/08/22.
//

import UIKit

class FeedCell: UITableViewCell {
   
    var delegate: deleteButtonWasTappedIn?
    var handler: ((_ type: Int) -> ())?
    var counter = 0
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var feedLabel: UILabel!
    @IBOutlet weak var cross: UIButton!
    var userId: String?
    var feedId: Int?
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    
    let userSql = DBManager.sharedInstance
    static let identifier = "FeedCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "FeedCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func configure(with model:Feedinfo){
        self.feedId = model.id
        self.userId = model.userId
        self.NameLabel.text = userSql.readAuthors(email: model.userId)
        self.feedLabel.text = model.feed
        counter = counter + 1;
        self.Label.text = String(counter)
        if let imagePath = getImageFromDocumentDirectory(imageName: model.feedImage) {
            self.UserImage.image = UIImage(contentsOfFile: imagePath)
            
        }
        cross.isHidden = hideDeleteButton()
    }
    
    func hideDeleteButton() -> Bool{
        if userId == loginEmailId {
           return false
        }
        return true
    }
    
    func getImageFromDocumentDirectory(imageName:String) -> String?{
           if FileManager.default.fileExists(atPath: getDirectory().appendingPathComponent(imageName).path) {
               return getDirectory().appendingPathComponent(imageName).path
           }
           return nil
       }

    
    
    @IBAction func deleteUser(_ sender: UIButton) {
        self.delegate?.deleteTapped(at: feedId)
    }
    @IBAction func likeBtn(_ sender: UIButton) {
        handler?(2)
    }
    @IBAction func commentBtn(_ sender: UIButton) {
        handler?(3)
    }
    @IBAction func shareBtn(_ sender: UIButton) {
        handler?(4)
    }
    
    @IBAction func moreBtn(_ sender: UIButton) {
        handler?(5)
    }
}


protocol deleteButtonWasTappedIn{
    func deleteTapped(at feedId: Int?)
}


