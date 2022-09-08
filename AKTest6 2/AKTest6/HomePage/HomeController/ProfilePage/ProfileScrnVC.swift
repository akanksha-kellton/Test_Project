//
//  ProfileScrnVC.swift
//  AKTest6
//
//  Created by IOS Training 2 on 23/08/22.
//

import UIKit

class ProfileScrnVC: UIViewController {

    let dbSharedInstance = DBManager.sharedInstance
    var userinfo: Userinfo = Userinfo()
    var abc: [Userinfo] = []
    var isEdit = false
    var handler: (() -> ())?
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var profileView: UITableView!
    
    var cellDataArray = [["", "", "","",""], ["", "",""]]
var datapass: (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registration"
        self.profileView.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")
        self.profileView.register(UINib(nibName: "RegisterCell", bundle: nil), forCellReuseIdentifier: "RegisterCell")
        self.profileView.register(UINib(nibName: "RegisterTableSection", bundle: nil), forHeaderFooterViewReuseIdentifier: "ReggisterTableSection")
        self.profileView.register(UINib(nibName: "UserProfile", bundle: nil), forCellReuseIdentifier: "UserProfile")
        
        profileView.delegate = self
        profileView.dataSource = self
        updateDataSource()
        showData()
    }
    func buttonClick(){

}

    private func updateDataSource() {
        abc = dbSharedInstance.read()
        profileView.reloadData()
    }
    func showData() {
        let register = NewRegisteration()
            self.updateDataSource()
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
        } else if !userinfo.EmailId.validateEmailId() {
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
        } else if self.userinfo.Address.count == 0 {
            self.showMessage(title: "Please enter valid address")
            return false
        }else if self.userinfo.State.count == 0 {
            self.showMessage(title: "Please enter valid state")
            return false
        } else if self.userinfo.Pincode.count != 6 {
            self.showMessage(title: "Please enter valid pincode")
            return false
        }
        return true
    }
}

extension ProfileScrnVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellDataArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 , indexPath.row == 0 {
            let cell = profileView.dequeueReusableCell(withIdentifier: "UserProfile", for: indexPath) as! UserProfile
            cell.setImage.setTitle("Logout", for: .normal)
            cell.delegate = self
            
            return cell
        }
        
    else if indexPath.section == 1, indexPath.row == cellDataArray[indexPath.section].count - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterCell", for: indexPath) as! RegisterCell
           
            
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

extension ProfileScrnVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let tag = textField.tag
        let text = textField.text ?? ""
        switch tag {
        case 1:
            userinfo.Name = text
        case 2:
            userinfo.EmailId = text
        case 3:
            userinfo.MobileNumber = text
        case 4:
            userinfo.Password = text
        case 5:
            userinfo.Confirmpassword = text
        case 6:
            userinfo.Address = text
        case 7:
            userinfo.State = text
        case 8:
            userinfo.Pincode = text
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileScrnVC: UserProfileDelegate{
    func didSelectImage() {
        UserDefault.setData(email: "", isLogin: false)
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginPage") as! LoginPage
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)

    
}

}

