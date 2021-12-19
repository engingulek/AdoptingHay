//
//  DogWalkingHomePage.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import UIKit

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
        cell.advertsRange.text = advert.range
        cell.adversKindsandAge.text = "Cins/Yaş: \(advert.kindsAndAge)"
        cell.advertsSick.text = "Hastalık: \(advert.sick)"
        
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
        performSegue(withIdentifier: "toDetailsWalking", sender: advert.dogWalkingAdvert )
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
