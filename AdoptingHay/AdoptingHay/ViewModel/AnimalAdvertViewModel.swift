//
//  AnimalAdvertViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.11.2021.
//

import Foundation


struct AnimalAdvertListViewModel {
    let animalAdvertList : [AnimalAdvert]
    
    
    func numberOfRowsInSection()-> Int {
        return self.animalAdvertList.count
    }
    
    
    func animalAdvertAtIndex(_ index:Int) ->
    AnimalAdvertViewModel {
        let advert = self.animalAdvertList[index]
        return AnimalAdvertViewModel(animalAdvert: advert)
    }
}


struct AnimalAdvertViewModel {
    let animalAdvert : AnimalAdvert
    
    
    var uuid : String {
        return self.animalAdvert.animalUid!
    }
    
    var name : String {
        return self.animalAdvert.animalName!
        
    }
    
    var age : String {
        return self.animalAdvert.animalAge!
    }
    
    
    var image:Data {
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
    
    
    
}
