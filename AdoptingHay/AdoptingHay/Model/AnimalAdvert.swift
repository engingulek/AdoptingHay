//
//  AnimalAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.10.2021.
//

import Foundation


class AnimalAdvert {
    var animalImage:String?
    var animalName:String?
    var animalKinds:String?
    var animalAge:Int?
    var animalSick:String?
    
    init(){
        
    }


    init(animalImage:String,animalName:String,animalKinds:String,animalAge:Int,animalSick:String){
        self.animalImage = animalImage
        self.animalName = animalName
        self.animalKinds = animalKinds
        self.animalSick = animalSick
        self.animalAge = animalAge
        
    }

    
}

