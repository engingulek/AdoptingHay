//
//  MyAdvertVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.12.2021.
//

import UIKit
import Firebase
class MyAdvertVC: UIViewController {
   
    
    @IBOutlet weak var myAdvertsCount: UILabel!
    private var myAnimalAdvertListViewModel : MyAnimalAdvertListViewModel!
    
 
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var myAdvertsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        myAdvertsCollectionView.delegate = self
        myAdvertsCollectionView.dataSource = self
        getMyAnimalAdvert()
        spinner.startAnimating()
    
    }
    
    
    
    func getMyAnimalAdvert() {
        let userId =  Auth.auth().currentUser?.uid
        if let userId = userId {
            Service().dowloadMyAnimalAdvert(uuid: userId) { myAnimal in
                if myAnimal == nil {
                    print("My advert list hata" )
                }
                
                else {
                    if let myAnimal = myAnimal {
                        self.myAnimalAdvertListViewModel = MyAnimalAdvertListViewModel(myAdvertList: myAnimal)
                        let counst = self.myAnimalAdvertListViewModel == nil ? 0 : self.myAnimalAdvertListViewModel.numberOfRowsInSection()
                        self.myAdvertsCount.text = "İlan Sayısı : \(counst)"
                        self.myAdvertsCollectionView.reloadData()
                        self.spinner.stopAnimating()
                        self.spinner.isHidden = true
                        
                    }
                   
                }
            }
            
        }
        
       
        
       
        
    }
    

    

    


}

extension MyAdvertVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myAnimalAdvertListViewModel == nil ? 0 : self.myAnimalAdvertListViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  myAdvertsCollectionView.dequeueReusableCell(withReuseIdentifier: "myadvertsCell", for: indexPath) as! MyAdvertsCVC
        
        
        let myAdvert = self.myAnimalAdvertListViewModel.animalAdvertAtIndex(indexPath.row)
        
        
        
        cell.advertName.text = "Adı : \(myAdvert.name)"
        cell.advertAge.text = "Yaş : \(myAdvert.age)"
        cell.advertGenus.text = "Cins : \(myAdvert.genus)"
        cell.advertSick.text = "Hastalık : \(myAdvert.sick)"
        let imageUrl = URL(string: myAdvert.image)!
        if let imageData = try? Data(contentsOf: imageUrl)
        {
            cell.advertImageView.image = UIImage(data: imageData)
        }
        
        
        cell.layer.cornerRadius = 25
  
         cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.red.cgColor
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
}
