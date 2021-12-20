//
//  DogMyAdvertDetail.swift
//  AdoptingHay
//
//  Created by engin gülek on 21.12.2021.
//

import UIKit

class DogMyAdvertDetail: UIViewController {
    var getAdvert: DogMyAdvert?
    
    @IBOutlet weak var animalImageView: UIImageView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    @IBOutlet weak var genusAgeLabel: UITextField!
    
    @IBOutlet weak var textViewSic: UITextView!
    
    

    @IBOutlet weak var textViewOwnerNote: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let getAdvert = getAdvert {
            nameLabel.text = getAdvert.animalName
            genusAgeLabel.text = getAdvert.ageAndGenus
            textViewSic.text = getAdvert.sickInfo
            textViewOwnerNote.text = getAdvert.ownerNote
            
     let a = (getAdvert.timeRange)!/30
            timePicker.countDownDuration = TimeInterval(1800*a)
//          timePicker.countDownDuration = TimeInterval(Int(getAdvert.timeRange!)!*1800)
            
            let imageUrl = URL(string:(getAdvert.animalImage)!)!
            
            if let imageData = try?  Data(contentsOf: imageUrl) {
                self.animalImageView.image = UIImage(data: imageData)
                
                
            }
        }
    }
    

    @IBAction func updateAdvert(_ sender: Any) {
    }
    

}
