//
//  DogWalkFav.swift
//  AdoptingHay
//
//  Created by engin gülek on 20.12.2021.
//

import Foundation

class DogFav {
    var advertId:String?
    var addImage:String?
    var time: Date?
    var timeRange:String?
    var animalName:String?
    var ageAndGenus:String?
    var sickBool:String?
    var sickInfo:String?
    var ownerNote:String?
    
    init(advertId:String,addImage:String,time: Date,timeRange:String,animalName:String,ageAndGenus:String,sickBool:String,sickInfo:String,ownerNote:String){
        
        self.addImage = addImage
        self.time = time
        self.timeRange = timeRange
        self.animalName = animalName
        self.ageAndGenus = ageAndGenus
        self.sickBool = sickBool
        self.sickInfo = sickInfo
        self.ownerNote = ownerNote
        self.advertId = advertId
        
        
    }
    
}

