//
//  CreateFeedVC.swift
//  AKTest6
//
//  Created by IOS Training 2 on 23/08/22.
//

import UIKit
import Photos
import Foundation

class CreateFeedVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var postTable: UITableView!
    @IBOutlet weak var feedText: UITextField!
    @IBOutlet weak var charLabel: UILabel!
    
    let sql = FeedDBManager.sharedInstance
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var feedinfo = Feedinfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedText.delegate = self
        self.postTable.register(UINib(nibName: "RegisterCell", bundle: nil), forCellReuseIdentifier: "RegisterCell")
        self.postTable.register(UINib(nibName: "UserProfile", bundle: nil), forCellReuseIdentifier: "UserProfile")
    }

    @IBAction func postBtn(_ sender: UIButton) {
        feedinfo.userId = loginEmailId
        sql.insert(userModel: feedinfo)
        self.navigationController?.popViewController(animated: true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        feedinfo.feed = textField.text ?? ""
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else{
            return false
        }
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        charLabel.text = "\(5000 - updateText.count) char Left"
        return updateText.count < 5000
    }
    
}

extension CreateFeedVC: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfile", for: indexPath)as! UserProfile
            cell.setImage.setTitle("Select feed image", for: .normal)
            cell.delegate = self
            return cell
        }
        else {
            return UITableViewCell()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 290
        }
        return 0
    }
    
    
}

extension CreateFeedVC: UserProfileDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func didSelectImage() {
        let imagePickerController: UIImagePickerController!
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated:true, completion: nil)
        imagePickerController.modalPresentationStyle = .fullScreen
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let cell = postTable.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! UserProfile
            cell.userImage.image = image
            
            let imageName = NSUUID().uuidString.lowercased()+".jpeg"
            feedinfo.feedImage = imageName
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: getDirectory().appendingPathComponent(imageName))
            }
            
            picker.dismiss(animated: true, completion: nil)
        }
        
        
        
    }
}
