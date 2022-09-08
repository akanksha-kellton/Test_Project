//
//  NewRegisteration.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//

import UIKit
import Photos
import Foundation

class NewRegisteration: UIViewController {
    
    let dbSharedInstance = DBManager.sharedInstance
    var userinfo: Userinfo = Userinfo()
    var isEdit = false
    var handler: (() -> ())?
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var registerView: UITableView!
    var cellDataArray = [["","Name", "Email Id", "Mobile Number", "Password", "Confirm password"], ["Address", "State", "Pincode", ""]]
var datapass: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Registration"
        self.registerView.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")
        self.registerView.register(UINib(nibName: "RegisterCell", bundle: nil), forCellReuseIdentifier: "RegisterCell")
        self.registerView.register(UINib(nibName: "RegisterTableSection", bundle: nil), forHeaderFooterViewReuseIdentifier: "ReggisterTableSection")
        self.registerView.register(UINib(nibName: "UserProfile", bundle: nil), forCellReuseIdentifier: "UserProfile")
        
        registerView.delegate = self
        registerView.dataSource = self
        
        
    }
    
    func saveDataIntoDB() {
        self.view.endEditing(true)
        if validate() {
            if userinfo.isCoredataBase {
                
            } else {
                DBManager.sharedInstance.insert(userModel: userinfo)
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    func validate() -> Bool {
        if userinfo.Name.count < 3 {
            self.showMessage(title: "Please enter valid name")
            return false
        } else if userinfo.EmailId.validateEmailId() {
            self.showMessage(title: "Please enter valid emailId")
            return false
        } else if userinfo.MobileNumber.count != 10 {
            self.showMessage(title: "Please enter valid mobile number")
            return false
        } else if userinfo.Password.count < 5 {
            self.showMessage(title: "Please enter valid password")
            return false
        } else if userinfo.Confirmpassword.count < 5 {
            self.showMessage(title: "Please enter valid confirm password")
            return false
        } else if self.userinfo.Password != userinfo.Confirmpassword {
            self.showMessage(title: "Please enter same password")
            return false
//        } else if self.userinfo.Address.count < 10 {
//            self.showMessage(title: "Please enter valid address")
//            return false
//        } else if self.userinfo.State.count == 0 {
//            self.showMessage(title: "Please enter valid state")
//            return false
//        } else if self.userinfo.Pincode.count != 6 {
//            self.showMessage(title: "Please enter valid pincode")
//            return false
        }
        return true
    }
}

extension NewRegisteration: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellDataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 , indexPath.row == 0 {
            let cell = registerView.dequeueReusableCell(withIdentifier: "UserProfile", for: indexPath) as! UserProfile
            cell.delegate = self
            cell.setImage.setTitle("Set Profile Pic", for: .normal)
            return cell
        }
        
        
    else if indexPath.section == 1, indexPath.row == cellDataArray[indexPath.section].count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell", for: indexPath) as! RegisterCell
           
            cell.handler = { type in
                if type == 1 {
                    self.saveDataIntoDB()
                }
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell
        cell.updateRegisterUI(indexPath: indexPath, userInfo: userinfo, placeHolder: cellDataArray[indexPath.section][indexPath.row])
        cell.emailfield.tag = indexPath.row
        cell.emailfield.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0, indexPath.section == 0 {
        return 200
        }
        else if indexPath.section == 0{
        return 90
        }
        else{
            return 90
        }
        
    }
    
}


extension NewRegisteration: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let tag = textField.tag
        let text = textField.text ?? ""
        switch tag {
        case 1:
            userinfo.Name = text
            print(text)
        case 2:
            userinfo.EmailId = text
            print(text)
        case 3:
            userinfo.MobileNumber = text
            print(text)
        case 4:
            userinfo.Password = text
            print(text)
        case 5:
            userinfo.Confirmpassword = text
            print(text)
        case 1000:
            userinfo.Address = text
            print(text)
        case 1001:
            userinfo.State = text
            print(text)
        case 1002:
            userinfo.Pincode = text
            print(text)
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension NewRegisteration: UserProfileDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate{
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
                   let cell = registerView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! UserProfile
                   cell.userImage.image = image
                   
                   
                  
                  }
              
               picker.dismiss(animated: true, completion: nil)
           }
}

