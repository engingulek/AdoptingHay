//
//  DogWalkingAdvertDetailsVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import UIKit

class DogWalkingAdvertDetailsVC: UIViewController {
    var getAdvertWalking: DogwalkingAdvert!
    
    @IBOutlet weak var advertImageView: UIImageView!
    
    @IBOutlet weak var advertRange: UILabel!
    
    @IBOutlet weak var advertAnimalName: UILabel!
    
    @IBOutlet weak var advertAnimalKindsAge: UILabel!
    
    @IBOutlet weak var animalSickInfo: UITextView!
    
    @IBOutlet weak var animalOwnerNote: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let imageUrl = URL(string: getAdvertWalking.advertImage!)!
        
        if let imageData = try?  Data(contentsOf: imageUrl) {
            advertImageView.image = UIImage(data: imageData)
            
        }
        

        advertAnimalName.text = "Adı: \(getAdvertWalking.advertAnimalName!)"
        
        advertRange.text = "\(getAdvertWalking.advertRange!)"
        advertAnimalKindsAge.text = "Cins-Yaş \(getAdvertWalking.advertAnimalKindsandAge!)"
        
        if getAdvertWalking.advertAnimalSick == "Yok" {
            self.animalSickInfo.isEditable = false
            self.animalSickInfo.text = ""
        }
        
        else {
            self.animalSickInfo.text = getAdvertWalking.sickInfo
        }
        animalOwnerNote.isEditable = false
        animalOwnerNote.text = getAdvertWalking.ownerNote
        
        

    
    }
    

    @IBAction func addFavAdvert(_ sender: Any) {
        DogWalkingService().addDogWalkingAdvert(getAdvert: getAdvertWalking!)
    }
    

}
