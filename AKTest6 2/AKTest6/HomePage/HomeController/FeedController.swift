//
//  ViewController.swift
//  AssignmentFive
//
//  Created by IOS Training 2 on 11/08/22.
//

import UIKit

class FeedController: UIViewController {
    
    @IBOutlet weak var create: UIButton!
    @IBOutlet weak var userTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var Searching = false
    let dbSharedInstance = StatusDBManager.sharedInstance
    let likedbshared = LikeDBManager.sharedInstance
    let sql = FeedDBManager.sharedInstance
    var feedData: Feedinfo = Feedinfo()
    var counter = 0
    var userinfo: Statusinfo = Statusinfo()
    var feed: [Feedinfo] = []
    var filteredData: [Feedinfo] = []
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTable.register(FeedCell.nib(), forCellReuseIdentifier: FeedCell.identifier)
        userTable.register(StatusTableViewCell.nib(), forCellReuseIdentifier: StatusTableViewCell.identifier)
        userTable.register(UINib(nibName: "UserProfile", bundle: nil), forCellReuseIdentifier: "UserProfile")
        
        userTable.delegate = self
        userTable.dataSource = self
        
        feed = sql.read()
        filteredData = sql.read()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        feed = sql.read()
        filteredData = sql.read()
        userTable.reloadData()
    }
    func saveStatusIntoDB() {
        self.view.endEditing(true)
        if userinfo.isCoredataBase1{
            
        }
        else
        {
            StatusDBManager.sharedInstance.insert(userModel: userinfo)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
//        func saveLikeIntoDB() {
//            self.view.endEditing(true)
//            if userinfo.isCoredataBase1 {
//    
//           }
//           else{
//               DBManager.sharedInstance.insert(userModel: feed)
//           }
//            self.navigationController?.popViewController(animated: true)
//        }
    
    
    
    @IBAction func createFeedBtn(_ sender: UIButton) {
        
    }

    func commentTapped() {
        let alert = UIAlertController(title: "Comment!", message: "Hit comment button", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func shareTapped() {
        let alert = UIAlertController(title: "Share!", message: "Hit share button", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    func moreTapped() {
        let alert = UIAlertController(title: "Oops!", message: "No function define", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}

extension FeedController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = userTable.dequeueReusableCell(withIdentifier: "StatusTableViewCell", for: indexPath) as! StatusTableViewCell
            cell.delegate = self
            self.saveStatusIntoDB()
            print("\(indexPath)")
            return cell
        }
        
        else  {
            let cell = userTable.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
            cell.configure(with: filteredData[indexPath.row - 1])
            cell.delegate = self
            cell.handler = { type in
                 if type == 3{
                    self.commentTapped()
                }
                else if type == 4{
                    self.shareTapped()
                }
                else{
                    self.moreTapped()
                }
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 350
        }
        return 500
    }
}
extension FeedController: UploadStatusDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func didUploadStatus() {
        if let upVC = self.storyBoard.instantiateViewController(withIdentifier: "UploadStatusVC") as? UploadStatusVC {
            self.navigationController?.pushViewController(upVC, animated: true)
        }
    }
}

extension FeedController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredData = feed
        }
        else {
            filteredData = feed.filter({$0.feed.lowercased().contains(searchText.lowercased())})
         }
    userTable.reloadData()
   }
}

extension FeedController: deleteButtonWasTappedIn{
    
    func deleteTapped(at feedId: Int?) {
        let alert = UIAlertController(title: nil, message: "Are you sure you'd like to delete this user", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [self] _ in
        self.feed.removeAll(where: ({$0.id == feedId}))
           self.filteredData.removeAll(where: ({$0.id == feedId}))
           if let feedId = feedId {
               sql.deleteData(id: feedId)
           }
           
        self.userTable.reloadData()
       }
           alert.addAction(yesAction)
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
           self.present(alert, animated: true, completion: nil)

    }
}
