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
        
        
       
        
        
        

        
     

        


        
        

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        getFavoriList()
        self.favoriteCollectionView.reloadData()
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
                        let counst = self.favoritListViewModel == nil ? 0 :  self.favoritListViewModel.numberOfRowsInSection()
                        
                        self.favoriCount.text = "Favori Sayısı : \(counst)"
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
