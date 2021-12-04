//
//  FavoriDetailsVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 3.12.2021.
//

import UIKit

class FavoriDetailsVC: UIViewController{
  
    
    var getAdvert : FavoritList?
    @IBOutlet weak var advertName: UILabel!
    @IBOutlet weak var favoriCollectionView: UICollectionView!
    
    @IBOutlet weak var advertAge: UILabel!
    @IBOutlet weak var advertGenus: UILabel!
    
    @IBOutlet weak var buttonInfoOutlet: UIButton!
    
    @IBOutlet weak var advertSick: UILabel!
    
    @IBOutlet weak var advertOwnerNot: UITextView!
    var animalImages:[Data] = [Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriCollectionView.delegate = self
        favoriCollectionView.dataSource = self
        favoriCollectionView.showsHorizontalScrollIndicator = false
        if let getAnimalname = getAdvert?.animalName {
            if let getAnimalGenus = getAdvert?.animalGenus {
                if let getAnimalKinds = getAdvert?.animalKinds {
                    if let getAnimalAge = getAdvert?.animalAge {
                        if let getAnimakSickBool = getAdvert?.animalSick{
                            if let getAnimalAdvertOwner = getAdvert?.animalOwnerNot {
                                
                                
                                self.advertName.text = "Adı : \(getAnimalname)"
                                self.advertGenus.text = "Cinsi : \(getAnimalKinds) / \(getAnimalGenus)  "
                                self.advertAge.text = "Yaş : \(getAnimalAge)"
                                self.advertSick.text = "Hastalık : \(getAnimakSickBool)"
                                self.advertOwnerNot.text = "\(getAnimalAdvertOwner)"
                                
                                
                                if getAnimakSickBool != "Yok" {
                                    self.buttonInfoOutlet.isHidden = false
                                   /* if let getAnimalSickInfo = getAnimalAdvert?.animalSickInfo {
                                        self.sicktoAlert = getAnimalSickInfo
                                    }*/
                                    
                                    
                                    
                                }
                                
                                if let getAnimalImageDetails = getAdvert?.imageDetails {
                                    for  a in getAnimalImageDetails {
                                        print("VciamgeDetails \(a)")
                                        let imageUrl = URL(string: "\(a)")!
                                        if let animalImageData = try?  Data(contentsOf: imageUrl) {
                                            
                                            print("kalae \(animalImageData)")
                                            
                                            self.animalImages.append(animalImageData)
                                            self.favoriCollectionView.reloadData()
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                    }
                                }
                                
                                
                                
                               }}}}}

        
    }
    
        

  

}
    
    @IBAction func removeFavoriAdvert(_ sender: Any) {
        if let advertUid = getAdvert?.animalUid {
            
            
    
            self.dismiss(animated: true) {
                Service().removeFavoriAdvert(advertId: advertUid)
                self.tabBarController?.selectedIndex = 0
                
            }
                       
        }
    }
    
    
    
}

extension FavoriDetailsVC :   UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = favoriCollectionView.dequeueReusableCell(withReuseIdentifier: "favoriDateilsImage", for: indexPath) as! FavoriDetailCVC
        cell.detailImage.image = UIImage(data: animalImages[indexPath.row])
        cell.layer.cornerRadius = 25
 
        cell.layer.borderWidth = 2
        return cell
        
        
        
    }
}
