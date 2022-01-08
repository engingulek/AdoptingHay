//
//  DogWalkingNotiVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import UIKit

class DogWalkingNotiVC: UIViewController {

    @IBOutlet weak var notiTableView: UITableView!
    var dogNotiViewModelList : DogNotificationViewModelList!
    override func viewDidLoad() {
        super.viewDidLoad()
        notiTableView.delegate = self
        notiTableView.dataSource = self
        getAllNoti()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        getAllNoti()
    }
    
    func  getAllNoti() {
        DogWalkingService().getAllDogWalkingNotifromFirebase { dogNoti in
            if let dogNoti = dogNoti {
                self.dogNotiViewModelList = DogNotificationViewModelList(dogNotificationList: dogNoti)
                self.notiTableView.reloadData()
            }
        }
        
        
    }
    

   

}

extension DogWalkingNotiVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dogNotiViewModelList == nil ? 0 : self.dogNotiViewModelList.dogNotificationListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notiTableView.dequeueReusableCell(withIdentifier: "dogNoti", for: indexPath) as! DogWalkingNotiTVC
        
        
        let dogNoti = self.dogNotiViewModelList.dogNotificationAtIndex(indexPath.row)
        print(" ald \(dogNoti.message)")
        cell.textLabel?.text = dogNoti.message
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Sil") { contextuaActcion, viewa, boolValue in
            let notiId = self.dogNotiViewModelList.dogNotificationAtIndex(indexPath.row).notiId
            
            DogWalkingService().removeDogWalkingAdvertNoti(notiId: notiId )
            self.dogNotiViewModelList.dogNotificationList.remove(at: indexPath.row)
            self.notiTableView.deleteRows(at: [indexPath], with: .fade)
     
          
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
        
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bildirimler"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let sendUserId =   self.dogNotiViewModelList.dogNotificationAtIndex(indexPath.row).sendUserId
        performSegue(withIdentifier: "toSendNotiAccount", sender: sendUserId)
      
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSendNotiAccount" {
            if let getSendId = sender as? String {
            let toNotiAccount = segue.destination as! NotiAccountVC
                toNotiAccount.getUserId = getSendId
            }
        }
    }
    

    
    
}
