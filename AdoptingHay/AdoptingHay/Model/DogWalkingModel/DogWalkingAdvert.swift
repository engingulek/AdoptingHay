//
//  DogWalkingAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import Foundation


class DogwalkingAdvert {
    var advertId:String?
    var advertImage:Data?
    var advertRange:String?
    var advertAnimalName:String?
    var advertAnimalKindsandAge:String?
    var advertAnimalSick:String?

    
    init(advertId:String,advertImage:Data,advertRange:String,advertAnimalName:String,advertAnimalKindsandAge:String,advertAnimalSick:String) {
        self.advertImage = advertImage
        self.advertRange = advertRange
        self.advertAnimalName = advertAnimalName
        self.advertAnimalKindsandAge = advertAnimalKindsandAge
        self.advertAnimalSick = advertAnimalSick
        
    }
}
