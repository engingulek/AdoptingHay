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
    var animalKindsTitle:[String] = [String]()
    var animalAdvertLists = [AnimalAdvert]()
    override func viewDidLoad() {
        super.viewDidLoad()

        getAnimalKindsFromFireStore()
        getAnimalAdvertFromFirebase()
        searchBar.delegate = self
        //  animalKindsCollectionView
        animalKindsCollectionView.delegate = self
        animalKindsCollectionView.dataSource = self
        
        animalKindsCollectionView.showsHorizontalScrollIndicator = false
       
        
        
        
        animalAdvertCollectionView.delegate = self
        animalAdvertCollectionView.dataSource = self
        
       
        

        
       
       
    
       
        
        
        
    }
    
    
    
    

    
    
    func getAnimalKindsFromFireStore(){
        let db = Firestore.firestore()
        db.collection("animalKinds").getDocuments { snapshot, error in
            if error != nil{
                print("Hata\(error?.localizedDescription)" ?? "Hata Oluştu")
            }
            
            else {
                for document in (snapshot?.documents)! {
                    if let animalKindName =  document.get("animalKindsName") as? String {
                        self.animalKindsTitle.append(animalKindName)
                    }
                    
                    if let animalKindsImage = document.get("animalKindsImage") as? String {
                        let imageUrl = URL(string: "\(animalKindsImage)")!
                        if let imageData = try?  Data(contentsOf: imageUrl) {
                            self.animalKindsImage.append(imageData)
                            
                        }
                        
                    }
                    
                }
            }
            self.animalKindsCollectionView.reloadData()
        }
        
    }
    
    
    
    
    func getAnimalAdvertFromFirebase(){
        
        
        let db = Firestore.firestore()
        db.collection("animalAdvert").getDocuments { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Bir hata oluştu")
            }
            else {
                for document in (snapshot?.documents)! {
                    if let animalAdvertUid = document.documentID as? String {
                        if let animalImage =  document.get("animalImage") as? String {
                            
                            let imageUrl = URL(string: "\(animalImage)")!
                            if let animalImageData = try?  Data(contentsOf: imageUrl) {
                                
                                if let animalName = document.get("animalName") as? String {
                                    if let animalAge = document.get("animalAge") as? Int {
                                        if let animalGenus = document.get("animalGenus") as? String {
                                            if let animalSick = document.get("animalSick") as? String {
                                                if let animalKinds = document.get("animalKinds") as? String {
                                                    let animal = AnimalAdvert(animalUid: animalAdvertUid, animalImage: animalImageData, animalName: animalName, animalKinds: "\(animalGenus)", animalAge: animalAge, animalSick: animalSick)
                                                    self.animalAdvertLists.append(animal)
                                                    
                                                    
                                               
                                                    
                                                }
                                                
                                                
                                                
                                            }
                                        }
                                    }
                                }
                               
                                
                            }
                            
                            
                            
                        }
                        
                    }
                   
                    
                }
            }
            self.animalAdvertCollectionView.reloadData()
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
            return animalAdvertLists.count
        }
        
        
            return animalKindsTitle.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.animalAdvertCollectionView {
            let cell = animalAdvertCollectionView.dequeueReusableCell(withReuseIdentifier: "animalAdvertCell", for: indexPath) as! AnimalAdvertCVC
            
            cell.animalAdvertImage.image = UIImage(data: animalAdvertLists[indexPath.row].animalImage!)
            
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
           
            cell.animaKindsIcon.image = UIImage(data: animalKindsImage[indexPath.row])
            
        
            cell.animalKindsTitle.text = animalKindsTitle[indexPath.row]
            cell.layer.cornerRadius = 25
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 2
            return cell
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.animalAdvertCollectionView {
            let animalAdvertUid = animalAdvertLists[indexPath.row].animalUid
            performSegue(withIdentifier: "homePageToAdvertDetails", sender: animalAdvertUid)
            
        }
       
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homePageToAdvertDetails" {
            
            if let dataUid = sender as? String {
                let toAnimalAdvertDetailVC = segue.destination as! AnimalAdvertDetailsVC
                toAnimalAdvertDetailVC.getAnimalAdvertUid = dataUid
            }
            
        }
    }
    
}








