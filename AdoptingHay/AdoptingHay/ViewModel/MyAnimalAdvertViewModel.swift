//
//  MyAnimalAdvertViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.12.2021.
//

import Foundation

struct MyAnimalAdvertListViewModel {
    let myAdvertList : [MyAdvert]
    
    
    func numberOfRowsInSection()-> Int {
        return self.myAdvertList.count
    }
    
    
    func animalAdvertAtIndex(_ index:Int) ->
    MyAnimalAdvertViewModel {
        let myAdvert = self.myAdvertList[index]
        return MyAnimalAdvertViewModel(myAdvert: myAdvert)
    }
    
    func allKinds () -> String {
        return "Hepsi"
    }
}


struct MyAnimalAdvertViewModel {
    let myAdvert : MyAdvert
    
    
    var uuid : String {
        return self.myAdvert.animaluuid!
    }
    
    
    
    var userId : String {
        return self.myAdvert.userid!
    }
    
    
    var userName : String {
        return self.myAdvert.userName!
        
    }
    
   
    
    
    
    
    var name : String {
        return self.myAdvert.animalName!
        
    }
    
    var age : Int {
        return self.myAdvert.animalAge!
    }
    
    
    var image:String {
        return self.myAdvert.animalImage!
    }
    
    var imageDetails: [String] {
        return self.myAdvert.animalImageDetails!
    }
    
    var genus : String {
        return self.myAdvert.animalGenus!
    }
    
    var kinds : String {
        return self.myAdvert.animalKinds!
    }
    
    var ownerNot: String {
        return self.myAdvert.animalOwnerNot!
    }
    
    var sick : String {
        return self.myAdvert.animalSickBool!
    }
    
    var sickInfo : String {
        return self.myAdvert.animalSickInfo!
    }
    
    
    
}

