//
//  DogWalkingHomePage.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import UIKit
import Firebase
class DogWalkingHomePage: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var dogWalkingCollectionView: UICollectionView!
    private var dogWalkingListViewModel: DogWalkingListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        spinner.isHidden = false
        
  
        dogWalkingCollectionView.delegate = self
        dogWalkingCollectionView.dataSource = self
        getAllAdvert()
        
 

       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllAdvert()
        dogWalkingCollectionView.reloadData()
    }
    
    
    
    @IBAction func dogWalkingAdvertFilter(_ sender: Any) {
        // Create Action Controller
        let actionController = UIAlertController(title: "Sıralama ve Filtreleme", message: "Uygu işlemei seçinniz", preferredStyle: .actionSheet)
        
        
        let timeRangeShortMaxToMin = UIAlertAction(title: "Süre Azalan", style: UIAlertAction.Style.default) { actin in
            
            DogWalkingService().timeFilter(filterType: true) { dogwalkingAdvert in
                if let dogwalkingAdvert = dogwalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogwalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                    
                    
                }
            }
            
        }
        
        let timeRangeMinToMax = UIAlertAction(title: "Süre Artan", style: .default) { action in
            DogWalkingService().timeFilter(filterType: false) { dogwalkingAdvert in
                if let dogwalkingAdvert = dogwalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogwalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                    
                    
                }
            }
            
        }
        
        let newDate = UIAlertAction(title: "En uzak tarih", style: .default) { action in
            DogWalkingService().dateFilter(filterType: true) { dogWalkingAdvert in
                
                if let dogWalkingAdvert = dogWalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogWalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                }
             
            }
            
        }
        
        
        let oldDate = UIAlertAction(title: "En yakın tarih", style: .default) { action in
            DogWalkingService().dateFilter(filterType: false) { dogWalkingAdvert in
                
                if let dogWalkingAdvert = dogWalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogWalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                }
             
            }
            
        }
        
        let sickFalse = UIAlertAction(title: "Hastalık Yok", style: .default) { action in
            DogWalkingService().sickFilter(sickBool: "Yok") { dogWalkingAdvert in
                if let dogWalkingAdvert = dogWalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogWalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                }
                
                
            }
            
        }
        
        let sickTrue = UIAlertAction(title: "Hastalık Var", style: .default) { action in
            DogWalkingService().sickFilter(sickBool: "Var") { dogWalkingAdvert in
                if let dogWalkingAdvert = dogWalkingAdvert {
                    self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: dogWalkingAdvert)
                    self.dogWalkingCollectionView.reloadData()
                    self.spinner.stopAnimating()
                    
                    self.spinner.isHidden = true
                }
                
            }
            
            
        }
        
        
        let all = UIAlertAction(title: "Hepsi", style: .destructive) { action in
            self.getAllAdvert()
        }
        
        let cancel = UIAlertAction(title: "İptal", style: .cancel) { action in
            print("İptal tıklandı")
        }
        
        actionController.addAction(timeRangeMinToMax)
        actionController.addAction(timeRangeShortMaxToMin)
        actionController.addAction(sickTrue)
        actionController.addAction(sickFalse)
        actionController.addAction(newDate)
        actionController.addAction(oldDate)
        actionController.addAction(all)
        actionController.addAction(cancel)
        
        
        self.present(actionController, animated: true, completion: nil)
        
        
        
    }
    
    
    // MARK : SERVICE CONNECT
    
    /// Get alll walking advert
    func getAllAdvert() {
        DogWalkingService().geDogWalkingAdvert { dogWalkingAdvert in
            if let walkingAdvert = dogWalkingAdvert {
                self.dogWalkingListViewModel = DogWalkingListViewModel(dogWalkingAdvertList: walkingAdvert)
                self.dogWalkingCollectionView.reloadData()
                self.spinner.stopAnimating()
                
                self.spinner.isHidden = true
          
                
            }
        }
    }
    

 

}

extension DogWalkingHomePage : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dogWalkingListViewModel == nil ? 0 : self.dogWalkingListViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dogWalkingCollectionView.dequeueReusableCell(withReuseIdentifier: "dogWalkingAdvertsCell", for: indexPath) as! DogWalkingAdvertsCVC
        
        let advert = self.dogWalkingListViewModel.animalKindsAtIndex(indexPath.row)
        
        cell.advertsName.text = "Adı: \(advert.name)  "
        cell.advertsRange.text = "\(advert.range) dk" 
        cell.adversKindsandAge.text = "Cins/Yaş: \(advert.kindsAndAge)"
        cell.advertsSick.text = "Hastalık: \(advert.sick)"
        cell.userName.text  = advert.userName
        cell.dateLabel.text = advert.addDate
      
        
        
        let imageUrl = URL(string:advert.image)!
        
        if let imageData = try?  Data(contentsOf: imageUrl) {
            cell.advertImageView.image = UIImage(data: imageData )
            
        }
        
        
      
        
        cell.layer.cornerRadius = 25
        
        cell.layer.borderWidth = 2
        
        cell.layer.borderColor = UIColor.blue.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let advert = self.dogWalkingListViewModel.animalKindsAtIndex(indexPath.row)
        if let authUserId = Auth.auth().currentUser?.uid {
            if authUserId == advert.userId {
                self.alertMessage(title: "Hata", messsage: "Kendi ilanınızdır")
            }
            else {
                performSegue(withIdentifier: "toDetailsWalking", sender: advert.dogWalkingAdvert )
                
            }
        }
        
    }
    
    
    // alert Message
    func alertMessage(title:String,messsage:String){
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController,animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsWalking" {
            
            if let getAdvert = sender as? DogwalkingAdvert {
                let toAdvertDetailVC = segue.destination as! DogWalkingAdvertDetailsVC
                print("İdd \(getAdvert.advertId)")
                toAdvertDetailVC.getAdvertWalking = getAdvert
                
            } }
    }
    
    
}
