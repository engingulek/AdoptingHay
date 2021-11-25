//
//  HomePageVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit
import Firebase

class HomePageVC: UIViewController {
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var animalKindsCollectionView: UICollectionView!
    
    @IBOutlet weak var animalAdvertCollectionView: UICollectionView!
    

    var animalKindsImage:[Data] = [Data]()
   // var animalKindsTitle:[String] = [String]()
    var animalAdvertLists = [AnimalAdvert]()
    
    
    
    private var animalKindsListViewModel : AnimalKindsListViewModel!
    private var animalAdvertListViewModel : AnimalAdvertListViewModel!
    

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        

        searchBar.delegate = self
        
        animalKindsCollectionView.delegate = self
        animalKindsCollectionView.dataSource = self
        
        animalKindsCollectionView.showsHorizontalScrollIndicator = false
       
        
        
        
        animalAdvertCollectionView.delegate = self
        animalAdvertCollectionView.dataSource = self

 // viewModel içirisine ihityacımız olan tüm listi vermiş olduk
        getAnimalKindsData()

        // viewModel içirisine ihityacımız olan tüm listi vermiş olduk()
        getAnimalAdvertData()

    }
    
    
    
    
    func getAnimalKindsData() {
        Service().dowlandAnimalKindsFromFirestore { (animalK) in
            if let animalK = animalK {
                self.animalKindsListViewModel = AnimalKindsListViewModel(animalKindsList: animalK)
                self.animalKindsCollectionView.reloadData()
            }
        }
    }
    
    func getAnimalAdvertData() {
        Service().dowlandAnimalAdvertFromFirestore { (animalA) in
            if let animalA = animalA {
                self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                self.animalAdvertCollectionView.reloadData()
            }
        }
        
    }
    
 
  

    
    

    
    
    
    
 
  

}

extension HomePageVC:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}



extension HomePageVC :UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.animalAdvertCollectionView {
            return self.animalAdvertListViewModel == nil ? 0 : self.animalAdvertListViewModel.numberOfRowsInSection()
        }
        
        
        return self.animalKindsListViewModel == nil ? 0 : self.animalKindsListViewModel.numberOfRowsInSection()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.animalAdvertCollectionView {
            let cell = animalAdvertCollectionView.dequeueReusableCell(withReuseIdentifier: "animalAdvertCell", for: indexPath) as! AnimalAdvertCVC
            
            
            let advertViewModel = self.animalAdvertListViewModel.animalAdvertAtIndex(indexPath.row)
            
            cell.animalAdvertImage.image = UIImage(data: advertViewModel.image)
            
            cell.animalAdvertNameLabel.text = "Adı: \(advertViewModel.name )"
            cell.animalAdvertKindsLabel.text = "Cins: \(advertViewModel.kinds)"
            cell.animalAdvertAgeLabel.text = "Yaş: \(String(advertViewModel.age))"
            cell.animalAdvertSickLabel.text = "Hastalık: \(advertViewModel.sick)"
           cell.layer.cornerRadius = 25
     
            cell.layer.borderWidth = 2
         
            return cell
        }
        
        else {
            let cell = animalKindsCollectionView.dequeueReusableCell(withReuseIdentifier: "animalKindsCell", for: indexPath) as! AnimalKindsCVC
            
            
            let kindsViewModel = self.animalKindsListViewModel.animalKindsAtIndex(indexPath.row)
           
            cell.animaKindsIcon.image = UIImage(data: kindsViewModel.image)
            
        
            cell.animalKindsTitle.text = kindsViewModel.name
              cell.layer.cornerRadius = 25
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 2
            return cell
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.animalAdvertCollectionView {
            
            let advertViewModel = self.animalAdvertListViewModel.animalAdvertAtIndex(indexPath.row)
            
            let animalAdvertUid = advertViewModel.uuid
            performSegue(withIdentifier: "homePageToAdvertDetails", sender: animalAdvertUid)
            
        }
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homePageToAdvertDetails" {
            
            if let dataUid = sender as? String {
                let toAnimalAdvertDetailVC = segue.destination as! AnimalAdvertDetailsVC
                toAnimalAdvertDetailVC.getAnimalAdvertUid = dataUid
            } }
    }
    
}








