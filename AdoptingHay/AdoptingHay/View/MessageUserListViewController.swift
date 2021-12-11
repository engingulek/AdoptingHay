//
//  MessageUserListViewController.swift
//  AdoptingHay
//
//  Created by engin gülek on 11.12.2021.
//

import UIKit

class MessageUserListViewController: UIViewController {

    @IBOutlet weak var messageUserListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        messageUserListTableView.delegate = self
        messageUserListTableView.dataSource = self
    }
    



}
extension MessageUserListViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageUserListTableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.text = "Deneme"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMessage", sender: nil)
    }
    
    
}







