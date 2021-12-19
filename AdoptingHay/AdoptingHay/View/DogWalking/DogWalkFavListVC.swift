//
//  DogWalkFavListVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.12.2021.
//

import UIKit

class DogWalkFavListVC: UIViewController {
    @IBOutlet weak var favListTableView: UITableView!
    var dogFavViewModelList : DogWalkingFavListViewModel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var advertCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
design()
        spinner.startAnimating()
        spinner.isHidden = false
        favListTableView.delegate = self
        favListTableView.dataSource = self
        getFavList()
      
    }
    
    override func viewDidAppear(_ animated: Bool) {

        self.favListTableView.reloadData()
        
        let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        if self.dogFavViewModelList == nil {
            self.favListTableView.isHidden = true
            self.advertCount.text = "0 İlan"
            myNameLabel.text = "Favori Listeniz Boş"
            myNameLabel.textAlignment = .center
            myNameLabel.center.x = self.view.center.x
            myNameLabel.center.y = self.view.center.y
            myNameLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            myNameLabel.textColor = .black
            self.view.addSubview(myNameLabel)
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
         
         else {
             self.favListTableView.isHidden  = false
             let counst = self.dogFavViewModelList == nil ? 0 :  self.dogFavViewModelList.numberOfRowsInSection()
             myNameLabel.isHidden = true
             self.advertCount.text = "\(counst) İlan"
             self.spinner.stopAnimating()
             self.spinner.isHidden = true
            
             
         }
    }
    
    
    
    func getFavList() {
        DogWalkingService().dowloandDogWalkingFavList { favLis in
            if let favLis = favLis {
                
                self.dogFavViewModelList = DogWalkingFavListViewModel(dogWalkingAdvertFav: favLis)
                self.favListTableView.reloadData()
                
                
            }
        }
        
        
    }
    
    
    
    // fav page header design
    func design() {
        let myNewView=UIView(frame: CGRect(x: 0, y: 95, width: view.frame.size.width, height: view.frame.height/6))
            myNewView.backgroundColor=UIColor.red
        myNewView.layer.zPosition = -1
        myNewView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        self.view.addSubview(myNewView)
        
        let personImage = UIImage(named: "heart")
        let myImageView:UIImageView = UIImageView()
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame.size.width = self.view.frame.width/4
        myImageView.frame.size.height = self.view.frame.height/8
        myImageView.center.x = self.view.center.x
        myImageView.center.y = self.view.center.y/2.5
        myImageView.image = personImage
        myImageView.backgroundColor = .white
        myImageView.layer.borderColor = UIColor.red.cgColor
        myImageView.layer.borderWidth = 3
        myImageView.layer.cornerRadius = 15
        myImageView.backgroundColor = UIColor.red
        self.view.addSubview(myImageView)
    }



}

extension DogWalkFavListVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dogFavViewModelList == nil ? 0 : self.dogFavViewModelList.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favListTableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! DogFavListTVC
        
        let favAdvert = self.dogFavViewModelList.animalKindsAtIndex(indexPath.row)
        
        
        cell.name.text = "Adı: \(favAdvert.name)"
        cell.kindAge.text = "Cins/Yaş: \(favAdvert.kindsAndAge)"
        cell.sickBool.text = "Hastalık \(favAdvert.sick)"
        cell.time.text = favAdvert.range
        
        print("Adı: \(favAdvert.name)")
        let imageUrl = URL(string:favAdvert.image)!
        
        if let imageData = try?  Data(contentsOf: imageUrl) {
            cell.animalImage.image = UIImage(data: imageData)
            
        }
        
        cell.layer.cornerRadius = 25
        
        cell.layer.borderWidth = 2
        
        cell.layer.borderColor = UIColor.blue.cgColor
        
   
        
    return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Kaldır") { contextuaActcion, viewa, boolValue in
            if let advertUid = self.dogFavViewModelList.animalKindsAtIndex(indexPath.row).advertId as? String{
                
                
        
                
                DogWalkingService().removeFavoriAdvert(advertId: advertUid)
                    self.dogFavViewModelList.dogWalkingAdvertFav.remove(at: indexPath.row)
                    self.favListTableView.deleteRows(at: [indexPath], with: .fade)
                
                    
                
                           
            }
            
     
          
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    
}
