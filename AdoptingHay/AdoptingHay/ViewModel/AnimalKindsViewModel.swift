//
//  AnimalKindsViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.11.2021.
//

import Foundation

struct AnimalKindsListViewModel {
    let animalKindsList : [AnimalKinds]
    
    func numberOfRowsInSection() -> Int {
        return self.animalKindsList.count
        
    }
    
    
    func animalKindsAtIndex(_ index: Int) -> AnimalKindsViewModel {
        let kinds = self.animalKindsList[index]
        return AnimalKindsViewModel(animalKinds: kinds)
        
    }
    
    

    
}


struct AnimalKindsViewModel {
    
    let animalKinds : AnimalKinds
    
    var name : String {
        return self.animalKinds.animalKindsName!
    }
    
    var image:Data {
        return self.animalKinds.animalKindsImage!
    }
    
    
    
}

