//
//  RequestListVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.12.2021.
//

import UIKit

class IncomingRequestListVC: UIViewController {
    @IBOutlet weak var requestListTableView: UITableView!
    var incomingRequestViewModeList: RequestInComigViewModelList!

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
 
    
    
 

    
    
    
    
  
    
    
}
