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
    var maxToMinBool:Bool = false

    var animalKindsImage:[Data] = [Data]()
   // var animalKindsTitle:[String] = [String]()
    var animalAdvertLists = [AnimalAdvert]()
    var getKinds : String = "nil"
    
    
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var spinnerKinds: UIActivityIndicatorView!
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

        // viewModel içirisine ihityacımız olan tüm listi vermiş olduk()
   

            
        
        
        
        
 // viewModel içirisine ihityacımız olan tüm listi vermiş olduk
        getAnimalKindsData()

        
      getAnimalAdvertData()
       
        spinner.startAnimating()
        spinnerKinds.startAnimating()
       
        
        self.animalAdvertCollectionView.reloadData()

    }

    
    override func viewDidAppear(_ animated: Bool) {
        getAnimalAdvertData()
        self.animalAdvertCollectionView.reloadData()
        
    }
    
  
            
            
       
       
    
    
    
    @IBAction func advertFilterButton(_ sender: Any) {
        
        
        let actionController = UIAlertController(title: "Sıralama ve Filtreleme", message: "Uygu işlemei seçinniz", preferredStyle: .actionSheet)
        
        
        
        
        let ageShortMaxtoMin = UIAlertAction(title: "Büyükten küçüğe", style: .default) {action in
            
            print("oluyor \(self.getKinds)")
            Service().dowlandAnimalAdvertAgeShortFromFirestore(kinds:self.getKinds,shortType: true) { animalA in
                    if let animalA = animalA {
                        self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                        print("Sayilasi sick bool\( self.animalAdvertListViewModel.animalAdvertList.count)")
                        self.animalAdvertCollectionView.reloadData()
                   
                    }
                    
                }
                
            
          
          
            
            
          
        }
        
    
        
        let ageShortMintoMax = UIAlertAction(title: "Küçükten büyüğe", style: .default) { action in
            
            
            Service().dowlandAnimalAdvertAgeShortFromFirestore(kinds:self.getKinds,shortType: false) { animalA in
                if let animalA = animalA {
                    self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                    print("Sayilasi sick bool\( self.animalAdvertListViewModel.animalAdvertList.count)")
                    self.animalAdvertCollectionView.reloadData()
               
                }
                
            }
            
            
            
            
        }
        
        
        let sickBoll = UIAlertAction(title: "Hastalık yok", style: .default) { action in
            
            Service().dowlandAnimalAdvertSickBoolFromFirestore(kinds: self.getKinds) { animalA in
                
                if animalA == nil {
                    self.getAnimalAdvertData()
                    self.alertMessage(title: "Uyarı", message: "Şuanda bu filtrelemede ilan bulunmamaktadır.")
                   
                    
                    
                }
                
                else {
                    if let animalA = animalA {
                        self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                      
                        self.animalAdvertCollectionView.reloadData()
                   
                    }
                    
                }
                
                
            }
        }
        
        
        
        let newAdvert = UIAlertAction(title: "Yeni İlanlar", style: .default) { action in
            Service().dowlandAnimalAdvertDateShortFromFirestore(shortType: true) { animalA in
                if let animalA = animalA {
                    self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                  
                    self.animalAdvertCollectionView.reloadData()
               
                }
                
            }
            
            
           
        }
        
        
        let oldAdvert = UIAlertAction(title: "Eski İlanlar", style: .default) { action in
            
            Service().dowlandAnimalAdvertDateShortFromFirestore(shortType: false) { animalA in
                if let animalA = animalA {
                    self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                  
                    self.animalAdvertCollectionView.reloadData()
               
                }
                
            }
            
           
        }
        
        
        let cancel = UIAlertAction(title: "İptal", style: .cancel) { action in
            print("İptal tıklandı")
        }
        
        actionController.addAction(sickBoll)
        actionController.addAction(cancel)
        actionController.addAction(ageShortMintoMax)
        actionController.addAction(ageShortMaxtoMin)
        actionController.addAction(newAdvert)
        actionController.addAction(oldAdvert)
        
        
        
        self.present(actionController, animated: true, completion: nil)
        
    }
    
    
    
    func getAnimalKindsData() {
        Service().dowlandAnimalKindsFromFirestore { (animalK) in
            if let animalK = animalK {
                self.animalKindsListViewModel = AnimalKindsListViewModel(animalKindsList: animalK)
               
                if self.animalKindsListViewModel.animalKindsList.count > 0 {
                    self.spinnerKinds.stopAnimating()
                    self.spinnerKinds.isHidden = true
                }
                self.animalKindsCollectionView.reloadData()
            }
        }
    }
    
    func getAnimalAdvertData() {
        Service().dowlandAnimalAdvertFromFirestore { (animalA) in
            if let animalA = animalA {
                self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                if self.animalAdvertListViewModel.animalAdvertList.count > 0 {
                    self.spinner.stopAnimating()
                    self.spinner.isHidden = true
                }
                
                self.animalAdvertCollectionView.reloadData()
                
                
            }}
        
    }
    
 
  

    
    

    
    
    
    
 
  

}

extension HomePageVC:UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        print("Arama \(searchText)")
        
        if searchText == "" {
            getAnimalAdvertData()
        }
        else {
            Service().dowlandAnimalAdvertSearchBarTextFromFirestore(getSeacrhBarText: searchText) { animalA in
                
                if let animalA = animalA {
                    self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                    self.animalAdvertCollectionView.reloadData()
            }
        } } }}



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
            
            
            let imageUrl = URL(string: "\(advertViewModel.image)")!
            if let animalImageData = try?  Data(contentsOf: imageUrl) {
                cell.animalAdvertImage.image = UIImage(data: animalImageData)
                
                
            }
            
//
            cell.advertId.text = "\(advertViewModel.advertid)"
            
            cell.animalAdvertNameLabel.text = "Adı: \(advertViewModel.name )"
            cell.animalAdvertKindsLabel.text = "Cins: \(advertViewModel.kinds)/\(advertViewModel.genus)"
            cell.animalAdvertAgeLabel.text = "Yaş: \(String(advertViewModel.age) )"
            cell.animalAdvertSickLabel.text = "Hastalık: \(advertViewModel.sick)"
            cell.advertUserName.text = "\(advertViewModel.userName)"
            
            cell.userId.text = "\(advertViewModel.userId)"
          
            print("Tarih \(advertViewModel.addDate)")
            
            cell.addFavoriteButton(advertViewModel)
            cell.dateLabel.text = "\(advertViewModel.addDate)"
            
           
            
            
           cell.layer.cornerRadius = 25
     
            cell.layer.borderWidth = 2
            
            cell.addFavoriteButton("ali")
         
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
          
            
          //  let animalAdvertUid = advertViewModel.advertid
           performSegue(withIdentifier: "homePageToAdvertDetails", sender: advertViewModel.animalAdvert)
            
            
        }
        
        
        
        
        
        
        if collectionView == self.animalKindsCollectionView {
            let kindsViewModel = self.animalKindsListViewModel.animalKindsAtIndex(indexPath.row)
            let getAnimalKinds = kindsViewModel.name
            self.getKinds = getAnimalKinds
            if getAnimalKinds == "Hepsi" {
                self.getAnimalAdvertData()
            }
            Service().dowlandAnimalAdvertKindsFilterFromFirestore(getAnimalKinds: getAnimalKinds) { animalA in
                
                if animalA == nil && getAnimalKinds != "Hepsi" {
                    self.alertMessage(title: "Uyarı", message: "Şuanda bu türde ilan bulunmamaktadır.")
              
                    
                    
                }
                
                else {
                    if let animalA = animalA {
                        
                       
                        self.animalAdvertListViewModel = AnimalAdvertListViewModel(animalAdvertList: animalA)
                    
                        self.animalAdvertCollectionView.reloadData()
                    }
                    
                }
                
                
               
                
                
                
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "homePageToAdvertDetails" {
             
             if let getAnimalAdvert = sender as? AnimalAdvert {
                 var toAnimalAdvertDetailVC = segue.destination as! AnimalAdvertDetailsVC
                 toAnimalAdvertDetailVC.getAnimalAdvert = getAnimalAdvert
             
                
             } }
     }
    
    
    
    func alertMessage (title:String,message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Kapat", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
 
    
}








