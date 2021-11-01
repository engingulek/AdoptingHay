//
//  AnimalAdvertDetailsVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.11.2021.
//

import UIKit

class AnimalAdvertDetailsVC: UIViewController {
 
    
   
    
    @IBOutlet weak var animalDetailsImagesCollectionView: UICollectionView!
    
    
    var animalImages:[String] = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalDetailsImagesCollectionView.delegate = self
        animalDetailsImagesCollectionView.dataSource = self
        animalDetailsImagesCollectionView.showsHorizontalScrollIndicator = false
        
        animalImages = ["pamukkopek","tarcinkedi","sarikus"]
        
        
        
        let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
        myNameLabel.text = "İlan Detay"
        myNameLabel.textAlignment = .center
        myNameLabel.center.x = self.view.center.x
        myNameLabel.center.y = self.view.center.y/8
        myNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        myNameLabel.textColor = .red
        self.view.addSubview(myNameLabel)
        
        
        
      
   
     
        
       
      

      
    }
    

    
    



}


extension AnimalAdvertDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = animalDetailsImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "animalDetailsImageCell", for: indexPath) as! AnimalAdvertDetailsImageCVC
        cell.animalmageDetails.image = UIImage(named: animalImages[indexPath.row])
        
        cell.layer.cornerRadius = 25
 
        cell.layer.borderWidth = 2
        return cell
            
        
        
    
        
  
    }
    
    
}
