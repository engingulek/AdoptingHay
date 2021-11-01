//
//  HomePageVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 14.10.2021.
//

import UIKit

class HomePageVC: UIViewController {
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var animalKindsCollectionView: UICollectionView!
    
    @IBOutlet weak var animalAdvertCollectionView: UICollectionView!
    

    var animalKinds:[String] = [String]()
    var animalKindsTitle:[String] = [String]()
    var animalAdvertLists = [AnimalAdvert]()
    override func viewDidLoad() {
        super.viewDidLoad()

       
        searchBar.delegate = self
        //  animalKindsCollectionView
        animalKindsCollectionView.delegate = self
        animalKindsCollectionView.dataSource = self
        
        animalKindsCollectionView.showsHorizontalScrollIndicator = false
        animalKinds = ["dog","cat","bird","hamster"]
        animalKindsTitle = ["Köpek","Kedi","Kuş","Hamster"]
        
        
        animalAdvertCollectionView.delegate = self
        animalAdvertCollectionView.dataSource = self
        
       
        
        getAnimalAdcertInfo()
    
       
        
        
        
    }
    
    
    func getAnimalAdcertInfo(){
        let animal1 = AnimalAdvert(animalImage: "pamukkopek", animalName: "Pamuk", animalKinds: "ÇovÇov/Köpek", animalAge: 3, animalSick: "YOK")
        
        let animal2 = AnimalAdvert(animalImage: "tarcinkedi", animalName: "Tarcin", animalKinds: "Siyam/Kedi", animalAge: 2, animalSick: "Var")
        
        let animal3 = AnimalAdvert(animalImage: "sarikus", animalName: "Sari", animalKinds: "Muhabbet/Kus", animalAge: 1, animalSick: "Yok")
        
        animalAdvertLists.append(animal1)
        animalAdvertLists.append(animal2)
        animalAdvertLists.append(animal3)
        
        
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
            return animalAdvertLists.count
        }
        return animalKinds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.animalAdvertCollectionView {
            let cell = animalAdvertCollectionView.dequeueReusableCell(withReuseIdentifier: "animalAdvertCell", for: indexPath) as! AnimalAdvertCVC
            
            cell.animalAdvertImage.image = UIImage(named: animalAdvertLists[indexPath.row].animalImage!)
            
            cell.animalAdvertNameLabel.text = "Adı: \(animalAdvertLists[indexPath.row].animalName ?? "")"
            cell.animalAdvertKindsLabel.text = "Cins: \(animalAdvertLists[indexPath.row].animalKinds ?? "")"
            cell.animalAdvertAgeLabel.text = "Yaş: \(String(animalAdvertLists[indexPath.row].animalAge!))"
            cell.animalAdvertSickLabel.text = "Hastalık: \(animalAdvertLists[indexPath.row].animalSick ?? "")"
            cell.layer.cornerRadius = 25
     
            cell.layer.borderWidth = 2
         
            return cell
        }
        
        else {
            let cell = animalKindsCollectionView.dequeueReusableCell(withReuseIdentifier: "animalKindsCell", for: indexPath) as! AnimalKindsCVC
            cell.animaKindsIcon.image = UIImage(named: "\(animalKinds[indexPath.row])")
            cell.animalKindsTitle.text = animalKindsTitle[indexPath.row]
            cell.layer.cornerRadius = 25
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 2
            return cell
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.animalAdvertCollectionView {
            performSegue(withIdentifier: "homePageToAdvertDetails", sender: nil)
            
        }
       
    }
    
}








