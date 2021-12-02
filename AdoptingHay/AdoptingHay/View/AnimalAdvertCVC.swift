//
//  AnimalAdvertCVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.10.2021.
//

import UIKit

class AnimalAdvertCVC: UICollectionViewCell {
    @IBOutlet weak var animalAdvertImage: UIImageView!
    @IBOutlet weak var animalAdvertNameLabel: UILabel!
    @IBOutlet weak var animalAdvertAgeLabel: UILabel!
    @IBOutlet weak var animalAdvertKindsLabel: UILabel!
    @IBOutlet weak var animalAdvertSickLabel: UILabel!
    @IBOutlet weak var advertId: UILabel!
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var addFavorite: UIButton!
    @IBOutlet weak var advertUserName: UILabel!
    @IBAction func addFavoriteButton(_ sender: Any) {
      
    }
}
