//
//  DogFavAdvertDetail.swift
//  AdoptingHay
//
//  Created by engin gülek on 20.12.2021.
//

import UIKit

class DogFavAdvertDetail: UIViewController {
    @IBOutlet weak var animalImage: UIImageView!
    var getAdvert:DogwalkingAdvert?
    
    @IBOutlet weak var advertDate: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var genusAge: UITextField!
    
    
    @IBOutlet weak var ownerNote: UITextView!
    @IBOutlet weak var sick: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.advertDate.isUserInteractionEnabled = false
        self.time.isUserInteractionEnabled = false
        self.name.isUserInteractionEnabled = false
        self.genusAge.isUserInteractionEnabled = false
        self.ownerNote.isUserInteractionEnabled = false
        self.sick.isUserInteractionEnabled = false
        getData()
         

        
    }
    
    
    func getData(){
        if let animalImage = getAdvert?.advertImage {
            let imageUrl = URL(string:(getAdvert?.advertImage)!)!
            
            if let imageData = try?  Data(contentsOf: imageUrl) {
                self.animalImage.image = UIImage(data: imageData)
                if let advertTime = getAdvert?.advertRange {
                    if let name = getAdvert?.advertAnimalName {
                        if let genusandAge = getAdvert?.advertAnimalKindsandAge {
                            if let sick = getAdvert?.sickInfo {
                                if let ownerNote = getAdvert?.ownerNote {
                                    self.time.text = advertTime
                                    self.name.text = name
                                    self.genusAge.text = genusandAge
                                    self.sick.text = sick
                                    self.ownerNote.text = ownerNote
                                }
                            }
                        }
                    }
                }
                
            
            
        }
    }
    }
    

//    let formatter = DateFormatter()
//    formatter.locale = NSLocale(localeIdentifier: "tr") as Locale
//    formatter.dateFormat = "dd/MMMM/yyyy"
//    return formatter.string(from: animalAdvert.dateEvent)

}
