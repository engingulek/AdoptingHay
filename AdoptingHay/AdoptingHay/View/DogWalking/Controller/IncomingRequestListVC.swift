//
//  RequestListVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.12.2021.
//

import UIKit
import Firebase
class IncomingRequestListVC: UIViewController {
    @IBOutlet weak var requestListTableView: UITableView!
    var incomingRequestViewModeList: RequestInComigViewModelList!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        requestListTableView.delegate = self
        requestListTableView.dataSource = self
        getAllRequest()
    }
    
    
    func getAllRequest() {
        DogWalkingService().getInComingRequestList { request in
            if let request = request {
                self.incomingRequestViewModeList = RequestInComigViewModelList(incomingList: request)
                self.requestListTableView.reloadData()
            }
          
        }
    
    }


}

extension IncomingRequestListVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.incomingRequestViewModeList == nil ? 0 : self.incomingRequestViewModeList.incomingListListCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = requestListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! IncomingRequestTVC
        let request = self.incomingRequestViewModeList.incomingRequestAtIndex(indexPath.row)
        cell.name.text = "Adı: \(request.name)"
        cell.range.text = String(request.range)
        cell.genusAge.text = "Cins/Yas: \(request.kindsAndAge)"
        cell.sickBool.text = "Hastalık: \(request.sick)"
        
        let imageUrl = URL(string:request.image)!
        
        if let imageData = try?  Data(contentsOf: imageUrl) {
            cell.animalImage.image = UIImage(data: imageData)
            
        }
        
        cell.layer.cornerRadius = 25
        
        cell.layer.borderWidth = 2
        
        cell.layer.borderColor = UIColor.green.cgColor
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "X") { contextuaActcion, viewa, boolValue in
            if let advertUid = self.incomingRequestViewModeList.incomingRequestAtIndex(indexPath.row).id as? String{
                if let sendUserId = self.incomingRequestViewModeList.incomingRequestAtIndex(indexPath.row).sendId as?
                        String {
                        DogWalkingService().removeComingRequest(id: advertUid,sendUserId:sendUserId)
                        self.incomingRequestViewModeList.incomingList.remove(at: indexPath.row)
                        self.requestListTableView.deleteRows(at: [indexPath], with: .fade)
                    
                    if let authUserName = Auth.auth().currentUser?.displayName {
                        let notiDate : [String:Any] = [
                            "sendUserName": authUserName, // gönderen kişi
                            "notiTitle":"AdoptingHay",
                            " notiSubtitle":"Gezdirme isteğiniz kabul edilmedi",
                            "notiMessage":"\(authUserName) gezdirme isteğinizi kabul etmedi",
                            "getUserName": "",  // alan kişi
                            "getUserId" : sendUserId
                        ]
                        
                        DogWalkingService().addDogWalkingAdvertNoti(notiData: notiDate,getUserId:sendUserId)
                    } }
            }
        }
        
        
        
        
        
        let requestToAccept = UIContextualAction(style: .normal, title: "√") { contextuaActcion, viewa, boolValue in
            let getAdvert = self.incomingRequestViewModeList.incomingRequestAtIndex(indexPath.row).incomingRequest
           
            
                DogWalkingService().acceptToRequestToFirebase(getAdvert: getAdvert )
            
                if let sendUserId = self.incomingRequestViewModeList.incomingRequestAtIndex(indexPath.row).sendId as?
                        String {
                    
                    
                    if let authUserName = Auth.auth().currentUser?.displayName {
                        let notiDate : [String:Any] = [
                            "sendUserName": authUserName, // gönderen kişi
                            "notiTitle":"AdoptingHay",
                            "notiSubtitle":"Gezdirme isteğiniz kabul edildi",
                            "notiMessage":"\(authUserName) gezdirme isteğinizi kabul etti",
                            "getUserName": "",  // alan kişi
                            "getUserId" : sendUserId
                        ]
                        
                        DogWalkingService().addDogWalkingAdvertNoti(notiData: notiDate,getUserId:sendUserId)
                    } }
            
            
                
            
            
        
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction,requestToAccept])
    }
    
 
    
    
 

    
    
    
    
  
    
    
}
