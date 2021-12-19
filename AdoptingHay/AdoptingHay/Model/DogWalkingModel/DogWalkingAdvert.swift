//
//  DogWalkingAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import Foundation


class DogwalkingAdvert {
    var advertId:String?
    var advertImage:String?
    var advertRange:String?
    var advertAnimalName:String?
    var advertAnimalKindsandAge:String?
    var advertAnimalSick:String?
    var ownerNote:String?
    var sickInfo:String?
    var userId:String?
    var userName:String?

    
    init(advertId:String,advertImage:String,advertRange:String,advertAnimalName:String,advertAnimalKindsandAge:String,advertAnimalSick:String,ownerNote:String,sickInfo:String,userId:String,userName:String) {
        self.advertImage = advertImage
        self.advertRange = advertRange
        self.advertAnimalName = advertAnimalName
        self.advertAnimalKindsandAge = advertAnimalKindsandAge
        self.advertAnimalSick = advertAnimalSick
        self.ownerNote = ownerNote
        self.sickInfo = sickInfo
        self.advertId = advertId
        self.userId = userId
        self.userName = userName
        
    }
}
