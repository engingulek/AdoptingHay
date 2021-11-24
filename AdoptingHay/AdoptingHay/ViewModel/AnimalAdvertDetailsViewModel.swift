//
//  AnimalAdvertDetailsViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.11.2021.
//

import Foundation

struct AnimalAdvertDetailsViewModel {
    
    
    let animalAdvertDetails : AnimalAdvertDetails
    
    
    var uuid : String {
        return self.animalAdvertDetails.animalUid!
    }
    
    var name : String {
        return self.animalAdvertDetails.animalName!
        
    }
    
    var age : Int {
        return self.animalAdvertDetails.animalAge!
    }
    
    
   
    var genus : String {
        return self.animalAdvertDetails.animalGenus!
    }
    
    var kinds : String {
        return self.animalAdvertDetails.animalKinds!
    }
    
    var ownerNot: String {
        return self.animalAdvertDetails.animalOwnerNot!
    }
    
    var sick : String {
        return self.animalAdvertDetails.animalSick!
    }
    
}
