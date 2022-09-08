//
//  LoginPage.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//

import UIKit

class LoginPage: UIViewController {
    
    var userinfo: Userinfo = Userinfo()
    
    let dbSharedInstance = DBManager.sharedInstance
    var sql = DBManager.sharedInstance
    
    @IBOutlet weak var loginView: UITableView!
    let inputcell = ["Email Id", "Password",""]
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginView.register(UINib(nibName: "TextCell", bundle: nil), forCellReuseIdentifier: "TextCell")
        self.loginView.register(UINib(nibName: "LoginBtnCell", bundle: nil), forCellReuseIdentifier: "LoginBtnCell")
        self.loginView.register(UINib(nibName: "NewRegisteration", bundle: nil), forCellReuseIdentifier: "NewRegisteration")
        
    }
    
    func submitButtonClicked() {
        self.view.endEditing(true)
        if self.validate() {
            if userinfo.isCoredataBase {
            } else {
                if let userDeail = sql.getUserDeatilsWithEmailId(emailId: userinfo.EmailId){
                    if userDeail.Password == userinfo.Password {
                        UserDefault.setData(email: userDeail.EmailId, isLogin: true)
                        
                        if let homeVC = self.storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController {
                            SceneDelegateRefrence.sDelegate?.window?.rootViewController = homeVC
                        }
                    } else {
                        self.showMessage(title: "Email id not exist with given password.")
                    }
                    
                }
            }
        }
    }
    
    func registrationButtionCLicked() {
        
        if let regdVC = self.storyBoard.instantiateViewController(withIdentifier: "NewRegisteration") as? NewRegisteration {
            self.navigationController?.pushViewController(regdVC, animated: true)
        }
    }
    func validate() -> Bool {
            
        if userinfo.EmailId.validateEmailId() {
            self.showMessage(title: "Please enter valid emailId")
            return false
        } else if !(userinfo.Password.count < 5) {
            self.showMessage(title: "Please enter valid password")
            return false
        }
        return true
    }
}
extension LoginPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputcell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoginBtnCell", for: indexPath) as! LoginBtnCell
            
            cell.handler = { type in
                if type == 1 {
                    self.registrationButtionCLicked()
                    
                } else {
                    self.submitButtonClicked()
                }
            }
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell
            cell.emailfield.tag = indexPath.row
            cell.emailfield.placeholder = inputcell[indexPath.row]
            cell.emailfield.delegate = self
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension LoginPage: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let tag = textField.tag
        let text = textField.text ?? ""
        switch tag {
        case 1:
            userinfo.EmailId = text
        case 2:
            userinfo.Password = text
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

