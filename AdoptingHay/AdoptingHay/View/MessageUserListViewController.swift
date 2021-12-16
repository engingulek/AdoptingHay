//
//  MessageUserListViewController.swift
//  AdoptingHay
//
//  Created by engin gülek on 11.12.2021.
//

import UIKit
import Firebase
import FirebaseAuth

class MessageUserListViewController: UIViewController {

    @IBOutlet weak var messageUserListTableView: UITableView!
    private var  messageUserListViewModel : MessageUserListViewModel!

    


    override func viewDidLoad() {
        super.viewDidLoad()

        messageUserListTableView.delegate = self
        messageUserListTableView.dataSource = self

            getMessageUserList()
        messageUserListTableView.reloadData()
            
        
       
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
            getMessageUserList()
        messageUserListTableView.reloadData()
            
        
        
    }
    
    func getMessageUserList(){
        Service().getAllMessageList { messageUserListA in
            if let messageUserListA = messageUserListA {
                self.messageUserListViewModel = MessageUserListViewModel(messageUserList: messageUserListA)
                self.messageUserListTableView.reloadData()
                
                print("Name user list : \( self.messageUserListViewModel.messsageUserListCount() ) ")
            }
            
            
        }
    }
    
    

    
    
    
   
    



}
extension MessageUserListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageUserListViewModel == nil ? 0 : self.messageUserListViewModel.messsageUserListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageUserListTableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.text = self.messageUserListViewModel.messageUserNameIndex(indexPath.row).name
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        performSegue(withIdentifier: "toMessage", sender: self.messageUserListViewModel.messageUserNameIndex(indexPath.row).id)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { contextuaActcion, viewa, boolValue in
            
            Service().deleteMessage(id:  self.messageUserListViewModel.messageUserNameIndex(indexPath.row).id)
            self.messageUserListViewModel.messageUserList.remove(at: indexPath.row)
            self.messageUserListTableView.deleteRows(at: [indexPath], with: .fade)
          
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessage"{
            if let id = sender as? String {
                let toChatVC = segue.destination as! ChatVC
                toChatVC.userId = id
                
           
                
            }
        }
    }
    
    
  
    
    //
    
    
}







