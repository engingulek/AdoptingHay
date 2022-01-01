//
//  DogWalkingMessageUserListVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.12.2021.
//

import UIKit

class DogWalkingMessageUserListVC: UIViewController {

    @IBOutlet weak var messaUserListTableView: UITableView!
    private var  messageUserListViewModel : MessageUserListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messaUserListTableView.delegate = self
        messaUserListTableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = false

     
    }
    
    func getMessageUserList(){
        DogWalkingService().getAllMessageList { messageUserListA in
            if let messageUserListA = messageUserListA {
                self.messageUserListViewModel = MessageUserListViewModel(messageUserList: messageUserListA)
                self.messaUserListTableView.reloadData()
                
                print("Name user list : \( self.messageUserListViewModel.messsageUserListCount() ) ")
            }
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        getMessageUserList()
        messaUserListTableView.reloadData()
    }
    
}

extension DogWalkingMessageUserListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.messageUserListViewModel == nil ? 0 : self.messageUserListViewModel.messsageUserListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messaUserListTableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.text = self.messageUserListViewModel.messageUserNameIndex(indexPath.row).name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
      
        
        
        performSegue(withIdentifier: "toMessage", sender: self.messageUserListViewModel.messageUserNameIndex(indexPath.row).id)
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { contextuaActcion, viewa, boolValue in
            
            DogWalkingService().deleteMessage(id:  self.messageUserListViewModel.messageUserNameIndex(indexPath.row).id)
            self.messageUserListViewModel.messageUserList.remove(at: indexPath.row)
            self.messaUserListTableView.deleteRows(at: [indexPath], with: .fade)
          
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessage" {
            if let id = sender as? String{
                let toDogChatVC = segue.destination as!
                DogChatVC
                toDogChatVC.userId = id
            }
        }
    }
    
    
}
