//
//  FavoriListVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 2.12.2021.
//

import UIKit
import Firebase

class FavoriListVC: UIViewController {
   
 
    private var favoritListViewModel : FavoritListViewModel!
    @IBOutlet weak var favoriListTableView: UITableView!

    
    @IBOutlet weak var advertCount: UILabel!
    @IBOutlet weak var favoriCount: UILabel!

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        favoriListTableView.delegate = self
        favoriListTableView.dataSource = self
        
     
        
        getFavoriList()
      
        
        
       
        
        
        

        
     
        
        design()


        
        

        
    }
    
    
    func design(){
       
    
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
    
    
    override func viewDidAppear(_ animated: Bool) {
      
        
        self.spinner.isHidden = true
       if self.favoritListViewModel == nil {
           self.favoriListTableView.isHidden = true
           self.advertCount.text = "0 İlan"
           
           let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
           myNameLabel.text = "Favori Listeniz Boş"
           myNameLabel.textAlignment = .center
           myNameLabel.center.x = self.view.center.x
           myNameLabel.center.y = self.view.center.y
           myNameLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
           myNameLabel.textColor = .black
           self.view.addSubview(myNameLabel)
          
          
              
           
            
        }
        
        else {
            self.favoriListTableView.isHidden = false
            let counst = self.favoritListViewModel == nil ? 0 :  self.favoritListViewModel.numberOfRowsInSection()
            
            self.advertCount.text = "\(counst) İlan"
           
            
        }
        
       
    }
    
 
    

    

    func getFavoriList() {
        let userId =  Auth.auth().currentUser?.uid
      
        if let userId = userId {
            Service().dowloadFavoriteListAdvert(uuid: userId) { myAnimal in
                if myAnimal == nil {
                    print("My advert list hata" )
                }
                
                else {
                    if let myAnimal = myAnimal {
                        self.favoritListViewModel = FavoritListViewModel(favoritList: myAnimal)
               
                        
                        
                        
                        self.favoriListTableView.reloadData()
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        
                        
                        
                      
                        
                    }
                   
                }
            }
        }
    }
    
    
    

}


extension  FavoriListVC  : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritListViewModel == nil ? 0 : self.favoritListViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  favoriListTableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! FavoriListTVC
        
        let favoriAdvert = self.favoritListViewModel.animalAdvertAtIndex(indexPath.row)
    
        let imageUrl = URL(string: "\(favoriAdvert.image)")
      
       if let animalImageData = try?  Data(contentsOf: imageUrl!) {
            
           cell.animalImage.image =  UIImage(data: animalImageData)
            
        }
        
       
        
        
   
        cell.animalName.text = "Adı : \(favoriAdvert.name)"
        cell.animalAge.text  = "Hastalık : \(favoriAdvert.age)"
        cell.animalKinds.text = "Cinsi : \(favoriAdvert.kinds) / \(favoriAdvert.genus)"
        cell.animalSick.text = "Hastalık : \(favoriAdvert.sick)"
        cell.userName.text = "\(favoriAdvert.userName)"
        cell.layer.cornerRadius = 25
  
         cell.layer.borderWidth = 2
        cell.frame.size.height = 160
        cell.layer.borderColor = UIColor.red.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.favoriListTableView {
            let favoriteViewModel = self.favoritListViewModel.animalAdvertAtIndex(indexPath.row)
            
            performSegue(withIdentifier: "favoriToDetails", sender: favoriteViewModel.favoritList)
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "favoriToDetails" {
             
        if let getAnimalAdvert = sender as? FavoritList {
                 let toFavoriDetailVC = segue.destination as! FavoriDetailsVC
            toFavoriDetailVC.getAdvert = getAnimalAdvert
             
                
             } }
     }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .destructive, title: "Kaldır") { contextuaActcion, viewa, boolValue in
            if let advertUid = self.favoritListViewModel.animalAdvertAtIndex(indexPath.row).uuid as? String{
                
                
        
                self.dismiss(animated: true) {
                    Service().removeFavoriAdvert(advertId: advertUid)
                    self.favoritListViewModel.favoritList.remove(at: indexPath.row)
                    self.favoriListTableView.deleteRows(at: [indexPath], with: .fade)
                
                    
                }
                           
            }
            
     
          
            
            
        }
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    
}




extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
