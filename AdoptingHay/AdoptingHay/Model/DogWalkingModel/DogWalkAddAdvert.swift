//
//  DogWalkAddAdvert.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.12.2021.
//

import Foundation

class DogWalkAddAdvert{
    var addImage:String?
    var time: Date?
    var timeRange:Int?
    var animalName:String?
    var ageAndGenus:String?
    var sickBool:String?
    var sickInfo:String?
    var ownerNote:String?
    var userId: String?
    var userName: String?
    
    init(userId: String,userName: String,addImage:String,time: Date,timeRange:Int,animalName:String,ageAndGenus:String,sickBool:String,sickInfo:String,ownerNote:String){
        
        self.addImage = addImage
        self.time = time
        self.timeRange = timeRange
        self.animalName = animalName
        self.ageAndGenus = ageAndGenus
        self.sickBool = sickBool
        self.sickInfo = sickInfo
        self.ownerNote = ownerNote
        self.userName = userName
        self.userId = userId
        
        
    }
    
}
