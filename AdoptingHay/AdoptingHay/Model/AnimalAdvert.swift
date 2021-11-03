//
//  AnimalAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.10.2021.
//

import Foundation


class AnimalAdvert {
    var animalUid:String
    var animalImage:Data?
    var animalName:String?
    var animalKinds:String?
    var animalAge:Int?
    var animalSick:String?
    


    init(animalUid:String,animalImage:Data,animalName:String,animalKinds:String,animalAge:Int,animalSick:String){
        self.animalUid = animalUid
        self.animalImage = animalImage
        self.animalName = animalName
        self.animalKinds = animalKinds
        self.animalSick = animalSick
        self.animalAge = animalAge
        
    }

    
}

