//
//  FavoriDetailsVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 3.12.2021.
//

import UIKit

class FavoriDetailsVC: UIViewController {
    var getAdvert : FavoritList?
    @IBOutlet weak var advertName: UILabel!
    
    @IBOutlet weak var advertAge: UILabel!
    @IBOutlet weak var advertGenus: UILabel!
    
    @IBOutlet weak var buttonInfoOutlet: UIButton!
    
    @IBOutlet weak var advertSick: UILabel!
    
    @IBOutlet weak var advertOwnerNot: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let getAnimalname = getAdvert?.animalName {
            if let getAnimalGenus = getAdvert?.animalGenus {
                if let getAnimalKinds = getAdvert?.animalKinds {
                    if let getAnimalAge = getAdvert?.animalAge {
                        if let getAnimakSickBool = getAdvert?.animalSick{
                            if let getAnimalAdvertOwner = getAdvert?.animalOwnerNot {
                                
                                
                                self.advertName.text = "Adı : \(getAnimalname)"
                                self.advertGenus.text = "Cinsi : \(getAnimalKinds) / \(getAnimalGenus)  "
                                self.advertAge.text = "Yaş : \(getAnimalAge)"
                                self.advertSick.text = "Hastalık : \(getAnimakSickBool)"
                                self.advertOwnerNot.text = "\(getAnimalAdvertOwner)"
                                
                                
                                if getAnimakSickBool != "Yok" {
                                    self.buttonInfoOutlet.isHidden = false
                                   /* if let getAnimalSickInfo = getAnimalAdvert?.animalSickInfo {
                                        self.sicktoAlert = getAnimalSickInfo
                                    }*/
                                    
                                    
                                    
                                }
                                
                                
                                
                               }}}}}

        
    }
    

  

}
}
