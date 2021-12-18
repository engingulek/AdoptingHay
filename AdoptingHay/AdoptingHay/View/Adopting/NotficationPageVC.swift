//
//  NotficationPageVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit

class NotficationPageVC: UIViewController{

    @IBOutlet weak var notficationTableView: UITableView!
  private  var notiViewModel:NotificationListViewModel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        notficationTableView.delegate = self
        notficationTableView.dataSource = self
        
        
        getNotification()
        
        
    
    }
    
    

    
    func getNotification(){
        print("deneme noti")
        
        Service().dowloandNotiList { noti in
            
            if noti == nil {
                print("Vc noti hata")
            }
            
            else {
                if let noti = noti {
                    self.notiViewModel = NotificationListViewModel(notiList: noti)
                    self.notficationTableView.reloadData()
                }
            }
      
            
            
        }
    
        
        
        
      
    }
    



}


extension NotficationPageVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notiViewModel == nil ? 0 : self.notiViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notficationTableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotficationTVC
        
        let notiCell = notiViewModel.animalAdvertAtIndex(indexPath.row)
        cell.notficationNameLabel.text = notiCell.sendName
        cell.notficationNotfiLabel.text = notiCell.message
        cell.notficationImageView.image = UIImage(named: "pp")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bildirimler"
        
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let notificationDelete = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, boolValue) in}
        return UISwipeActionsConfiguration(actions: [notificationDelete])}
}
