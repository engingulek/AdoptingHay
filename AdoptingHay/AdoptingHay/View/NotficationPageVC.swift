//
//  NotficationPageVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit

class NotficationPageVC: UIViewController{

    @IBOutlet weak var notficationTableView: UITableView!
    
    var notificationLists:[Notification] = [Notification]()
    override func viewDidLoad() {
        super.viewDidLoad()

        notficationTableView.delegate = self
        notficationTableView.dataSource = self
        
        
        getNotification()
        
        
    
    }
    
    
    func getNotification(){
        let notification1 = Notification(id: 1, notificationImage: "person", notificationName: "Engin Gülek", notificationNoti: "ajdjadjsjdkajkdjasda")
        let notification2 = Notification(id: 2, notificationImage: "person", notificationName: "Ali Kaya", notificationNoti: "a9494494a")
        let notification3 = Notification(id: 3, notificationImage: "person", notificationName: "Hkmet", notificationNoti: "a99494030303")
        let notification4 = Notification(id: 4, notificationImage: "person", notificationName: "Ayşe Sevinç", notificationNoti: "11111111da")
        let notification5 = Notification(id: 5, notificationImage: "person", notificationName: "Kerime", notificationNoti: "ajdjadjsjdkajkdjasda")
        
        
        
        notificationLists.append(notification1)
        notificationLists.append(notification2)
        notificationLists.append(notification3)
        notificationLists.append(notification4)
        notificationLists.append(notification5)
    }
    



}


extension NotficationPageVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notficationTableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotficationTVC
        cell.notficationNameLabel.text = "\(notificationLists[indexPath.row].notificationName ?? "Belirtilmemiş")"
        cell.notficationNotfiLabel.text = "\(notificationLists[indexPath.row].notificationNoti ?? "Belirtilmemiş")"
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bildirimler"
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let notificationDelete = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, boolValue) in
            print("\(self.notificationLists[indexPath.row].id ) silindi")
        }
        
        let notificationBlock = UIContextualAction(style: .normal, title: "Engelle") { (contextualAction, view, boolValue) in
            print("\(self.notificationLists[indexPath.row].id) silindi")
        }
        
        
        return UISwipeActionsConfiguration(actions: [notificationDelete,notificationBlock])
    }
    
    
}
