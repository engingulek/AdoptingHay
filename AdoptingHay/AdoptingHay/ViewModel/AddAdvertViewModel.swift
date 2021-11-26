//
//  AddAdvertViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 25.11.2021.
//

import Foundation


struct AddAdvertViewModel {
    let addAdvert : AddAdvert
    
    
    var uuid : String {
        return self.addAdvert.uuid!
    }
    
    
    var userName : String {
        return self.addAdvert.userName!
    }
    
    var name : String {
        return self.addAdvert.animalName!
    }
    
    var age : String {
        return self.addAdvert.animalAge!
    }
    
    var genus : String {
        return self.addAdvert.animalGenus!
    }
    
    var kinds : String {
        return self.addAdvert.animalKinds!
    }
    
    
    var ownerNot: String {
        return self.addAdvert.animalOwnerNot!
    }
    
    var sick : String {
        return self.addAdvert.animalSickInfo!
    }
    
    var animalImageDetails : [String] {
       
        
        return self.addAdvert.animalImageDetails!
        
    }
    
    var animalImage : String {
        return self.addAdvert.animalImage!
    }
    
    
    
    
    
}
