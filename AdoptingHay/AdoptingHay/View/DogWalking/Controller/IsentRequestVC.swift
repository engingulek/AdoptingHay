//
//  IsentRequestVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.12.2021.
//

import UIKit
import Firebase
class IsentRequestVC: UIViewController {
    @IBOutlet weak var isentRequestTableView: UITableView!
    var isentRequestListViewModel:RequestInSentViewModelList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isentRequestTableView.delegate = self
        isentRequestTableView.dataSource = self
        getAllRequest()

        
    }
    
    
    func getAllRequest() {
        DogWalkingService().isendRequestList { request in
            if let request = request {
                self.isentRequestListViewModel = RequestInSentViewModelList(isentList: request)
                self.isentRequestTableView.reloadData()
            }
          
        }
    
    }


}

extension IsentRequestVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isentRequestListViewModel == nil ? 0 : self.isentRequestListViewModel.insentListListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = isentRequestTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! IsentRequestTVC
        
        let request = self.isentRequestListViewModel.insentRequestAtIndex(indexPath.row)
        cell.name.text = "Adı: \(request.name)"
        cell.range.text = String(request.range)
        cell.genusAge.text = "Cins/Yas: \(request.kindsAndAge)"
        cell.sick.text = "Hastalık: \(request.sick)"

       let imageUrl = URL(string:request.image)!

      if let imageData = try?  Data(contentsOf: imageUrl) {
          cell.animalImage.image = UIImage(data: imageData)

        }
        
        cell.layer.cornerRadius = 25
        
        cell.layer.borderWidth = 2
        
        cell.layer.borderColor = UIColor.red.cgColor
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Vazgeç") { contextuaActcion, viewa, boolValue in
            if let advertUid = self.isentRequestListViewModel.insentRequestAtIndex(indexPath.row).id as? String{
                
                
                if let advertOwnerUserId = self.isentRequestListViewModel.insentRequestAtIndex(indexPath.row).userId as? String{
                    DogWalkingService().removeISendRequest(id: advertUid,advertOwnerUserId:advertOwnerUserId)
                    self.isentRequestListViewModel.isentList.remove(at: indexPath.row)
                    self.isentRequestTableView.deleteRows(at: [indexPath], with: .fade)
                    
                    //send notification
                    if let authUserName = Auth.auth().currentUser?.displayName {
                        let notiDate : [String:Any] = [
                            "sendUserName": authUserName, // gönderen kişi
                            "notiTitle":"AdoptingHay",
                            " notiSubtitle":"Gezdirme isteğinden vazgeçti",
                            "notiMessage":"\(authUserName) gezdirme isteğinden fazgeçti",
                            "getUserName": "",  // alan kişi
                            "getUserId" : advertOwnerUserId
                        ]
                        
                        DogWalkingService().addDogWalkingAdvertNoti(notiData: notiDate,getUserId:advertOwnerUserId)
                    }

                }
            }
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }

}
