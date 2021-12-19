//
//  DogWalkingNotiVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import UIKit

class DogWalkingNotiVC: UIViewController {

    @IBOutlet weak var notiTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        notiTableView.delegate = self
        notiTableView.dataSource = self
        
    }
    

   

}

extension DogWalkingNotiVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notiTableView.dequeueReusableCell(withIdentifier: "dogNoti", for: indexPath) as! DogWalkingNotiTVC
        cell.textLabel?.text = "Engin Gülek ilanınızı favorilerine ekledi"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Bildirimler"
    }
    
    
}
