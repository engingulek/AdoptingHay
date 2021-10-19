//
//  NotficationPageVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit

class NotficationPageVC: UIViewController{

    @IBOutlet weak var notficationTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        notficationTableView.delegate = self
        notficationTableView.dataSource = self
        
        
    
    }
    



}


extension NotficationPageVC: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notficationTableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotficationTVC
      
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bildirimler"
    }
    
    
}
