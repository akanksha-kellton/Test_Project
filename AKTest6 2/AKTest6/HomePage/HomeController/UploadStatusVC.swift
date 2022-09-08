//
//  UploadStatusVC.swift
//  AKTest6
//
//  Created by IOS Training 2 on 23/08/22.
//

import UIKit

class UploadStatusVC: UIViewController {

   
    let dbSharedInstance = StatusDBManager.sharedInstance
    var statusinfo: Statusinfo = Statusinfo()
    @IBOutlet weak var uploadSts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.uploadSts.register(UINib(nibName: "RegisterCell", bundle: nil), forCellReuseIdentifier: "RegisterCell")
        self.uploadSts.register(UINib(nibName: "UserProfile", bundle: nil), forCellReuseIdentifier: "UserProfile")
        
        
    }
    
    func postStatus(){
    self.view.endEditing(true)
        
            if statusinfo.isCoredataBase1 {
                
            } else {
                StatusDBManager.sharedInstance.insert(userModel: statusinfo)
            }
            self.navigationController?.popViewController(animated: true)
        }
    
    
}

extension UploadStatusVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = uploadSts.dequeueReusableCell(withIdentifier: "UserProfile", for: indexPath) as! UserProfile
            cell.delegate = self
            
            return cell
        }
        else {
            let cell = uploadSts.dequeueReusableCell(withIdentifier: "RegisterCell", for: indexPath) as! RegisterCell
            cell.handler = { type in
                if type == 1 {
                    self.postStatus()
                }
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
        return 290
        }
        return 80
        
    }
    
}

extension UploadStatusVC: UserProfileDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate{
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
                   let cell = uploadSts.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! UserProfile
                   cell.userImage.image = image
                  
                  }
              
               picker.dismiss(animated: true, completion: nil)
           }


    
}

