//
//  FavoritListViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 2.12.2021.
//

import Foundation

struct FavoritListViewModel {
    var favoritList : [FavoritList]
    
    
    func numberOfRowsInSection()-> Int {
        return self.favoritList.count
    }
    
    
    func animalAdvertAtIndex(_ index:Int) ->
    FavoritViewModel {
        let favorite = self.favoritList[index]
        return FavoritViewModel(favoritList: favorite)
    }
    

}


struct FavoritViewModel {
    let favoritList : FavoritList
    
    
    var uuid : String {
        return self.favoritList.animalUid!
    }
    
    
    
    var userId : String {
        return self.favoritList.userId!
    }
    
    
    var userName : String {
        return self.favoritList.userName!
        
    }
    
   
    
    
    
    
    var name : String {
        return self.favoritList.animalName!
        
    }
    
    var age : Int {
        return self.favoritList.animalAge!
    }
    
    
    var image:String {
        print("adsd \(self.favoritList.animalImage)")
        return self.favoritList.animalImage!
    }
    
    var imageDetails: [String] {
        return self.favoritList.imageDetails
    }
    
    var genus : String {
        return self.favoritList.animalGenus!
    }
    
    var kinds : String {
        return self.favoritList.animalKinds!
    }
    
    var ownerNot: String {
        return self.favoritList.animalOwnerNot!
    }
    
    var sick : String {
        return self.favoritList.animalSick!
    }
    
    var sickInfo : String {
        return self.favoritList.animalSickInfo!
    }
    
    
    
}
