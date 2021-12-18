//
//  AnimalKinds.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.11.2021.
//

import Foundation
import FirebaseFirestoreSwift
struct AnimalKinds   {

    var animalKindsImage:Data?
    var animalKindsName:String?
    
    init(animalKindsName:String,animalKindsImage:Data) {
        self.animalKindsName = animalKindsName
        self.animalKindsImage = animalKindsImage
    }
    
    
}



