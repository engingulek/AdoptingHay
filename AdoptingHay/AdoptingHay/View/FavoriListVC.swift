//
//  FavoriListVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 2.12.2021.
//

import UIKit
import Firebase

class FavoriListVC: UIViewController {
   
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    private var favoritListViewModel : FavoritListViewModel!
    
    @IBOutlet weak var advertCount: UILabel!
    @IBOutlet weak var favoriCount: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        getFavoriList()
        spinner.startAnimating()
        self.favoriteCollectionView.reloadData()
        
        
       
        
        
        

        
     
        
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
        getFavoriList()
        self.favoriteCollectionView.reloadData()
        
        
       if self.favoritListViewModel == nil {
           self.favoriteCollectionView.isHidden = true
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
            self.favoriteCollectionView.isHidden = false
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
               
                        
                        
                        
                        self.favoriteCollectionView.reloadData()
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        
                        
                        
                      
                        
                    }
                   
                }
            }
        }
    }
    
    
    

}

extension FavoriListVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.favoritListViewModel == nil ? 0 : self.favoritListViewModel.numberOfRowsInSection()
       
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: "favoriCell", for: indexPath) as! FavoritListCVC
        
        let favoriAdvert = self.favoritListViewModel.animalAdvertAtIndex(indexPath.row)
    
        let imageUrl = URL(string: "\(favoriAdvert.image)")
      
       if let animalImageData = try?  Data(contentsOf: imageUrl!) {
            
            cell.imageView.image =  UIImage(data: animalImageData)
            
        }
        
       
        
        
   
        cell.animalName.text = "Adı : \(favoriAdvert.name)"
        cell.animalAge.text  = "Hastalık : \(favoriAdvert.age)"
        cell.animalGenus.text = "Cinsi : \(favoriAdvert.kinds) / \(favoriAdvert.genus)"
        cell.animalSick.text = "Hastalık : \(favoriAdvert.sick)"
        cell.userName.text = "\(favoriAdvert.userName)"
        cell.layer.cornerRadius = 25
  
         cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.red.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.favoriteCollectionView  {
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
    
    
    
    
    
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
