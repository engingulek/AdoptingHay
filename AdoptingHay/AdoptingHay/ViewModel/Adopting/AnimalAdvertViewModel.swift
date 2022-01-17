//
//  AnimalAdvertViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.11.2021.
//

import Foundation


struct AnimalAdvertListViewModel {
    var animalAdvertList : [AnimalAdvert]
    
    
    func numberOfRowsInSection()-> Int {
        return self.animalAdvertList.count
    }
    
    
    func animalAdvertAtIndex(_ index:Int) ->
    AnimalAdvertViewModel {
        let advert = self.animalAdvertList[index]
        return AnimalAdvertViewModel(animalAdvert: advert)
    }
    
    func allKinds () -> String {
        return "Hepsi"
    }
}


struct AnimalAdvertViewModel {
    let animalAdvert : AnimalAdvert
    
    
    var advertid : String {
        return self.animalAdvert.animalUid!
    }
    
    var name : String {
        return self.animalAdvert.animalName!
        
    }
    
    var age : Int {
        return self.animalAdvert.animalAge!
    }
    
    
    var image:String {
        return self.animalAdvert.animalImage!
    }
    
    var genus : String {
        return self.animalAdvert.animalGenus!
    }
    
    var kinds : String {
        return self.animalAdvert.animalKinds!
    }
    
    var ownerNot: String {
        return self.animalAdvert.animalOwnerNot!
    }
    
    var sick : String {
        return self.animalAdvert.animalSick!
    }
    var userName : String {
        return self.animalAdvert.userName!
        
    }
    
    var userId : String {
        return self.animalAdvert.userId!
    }
    var addDate : String {
        
        var dateString : String {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "tr") as Locale
            formatter.dateFormat = "dd/MMMM/yyyy"
            return formatter.string(from: animalAdvert.dateEvent)
        }
        return dateString
        
        
    }
    
    
    
}
