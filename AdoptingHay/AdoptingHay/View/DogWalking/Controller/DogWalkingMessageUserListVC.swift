//
//  DogWalkingMessageUserListVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.12.2021.
//

import UIKit

class DogWalkingMessageUserListVC: UIViewController {

    @IBOutlet weak var messaUserListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messaUserListTableView.delegate = self
        messaUserListTableView.dataSource = self
        self.tabBarController?.tabBar.isHidden = false

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension DogWalkingMessageUserListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messaUserListTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        cell.textLabel?.text = "Engimn Gülek"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMessage", sender: nil)
    }
    
    
}
