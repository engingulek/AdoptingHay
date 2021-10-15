//
//  HomePageVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit

class HomePageVC: UIViewController{
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var animalKindsCollectionView: UICollectionView!
    
   

    var animalKinds:[String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        accountButton.layer.cornerRadius = 10
        searchBar.delegate = self
        
        animalKindsCollectionView.delegate = self
        animalKindsCollectionView.dataSource = self
        animalKindsCollectionView.showsHorizontalScrollIndicator = false
        animalKinds = ["cat","bird","hamster"]
        
    
       
        
        
        
    }
    
    

  

}

extension HomePageVC:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension HomePageVC :UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalKinds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = animalKindsCollectionView.dequeueReusableCell(withReuseIdentifier: "animalKindsCell", for: indexPath) as! AnimalKindsCVC
        cell.animaKindsIcon.image = UIImage(named: "\(animalKinds[indexPath.row])")
     
      
      
        return cell
        
        
    }
    
    
}






