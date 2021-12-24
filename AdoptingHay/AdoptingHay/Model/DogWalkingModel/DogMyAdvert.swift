//
//  DogMyAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 20.12.2021.
//

import Foundation

class DogMyAdvert {
    var animalImage:String?
    var time: Date?
    var timeRange:Int?
    var animalName:String?
    var ageAndGenus:String?
    var sickBool:String?
    var sickInfo:String?
    var ownerNote:String?
    var userId: String?
    var userName: String?
    var advertId:String?
    var situation:String?
          
    
    init(userId: String,userName: String,animalImage:String,time: Date,timeRange:Int,animalName:String,ageAndGenus:String,sickBool:String,sickInfo:String,ownerNote:String,advertId:String,situation:String){
        
        self.animalImage = animalImage
        self.time = time
        self.timeRange = timeRange
        self.animalName = animalName
        self.ageAndGenus = ageAndGenus
        self.sickBool = sickBool
        self.sickInfo = sickInfo
        self.ownerNote = ownerNote
        self.userName = userName
        self.userId = userId
        self.advertId = advertId
        self.situation = situation
        
        
    }
}
