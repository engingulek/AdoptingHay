//
//  IsentRequestVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.12.2021.
//

import UIKit

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
    
    
}
