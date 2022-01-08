//
//  Notification.swift
//  AdoptingHay
//
//  Created by engin gülek on 22.12.2021.
//

import Foundation

class DogNotification {
    var notiId:String?
    var sendUserName:String?
    var notiTitle:String?
    var notiSubtitle:String?
    var notiMessage:String?
    var getUserName:String?
    var sendUserId:String?
    
    init(notiId:String,sendUserName:String,notiTitle:String,notiSubtitle:String,notiMessage:String,getUserName:String,sendUserId:String) {
        self.notiId = notiId
        self.sendUserName = sendUserName
        self.notiTitle = notiTitle
        self.notiSubtitle = notiSubtitle
        self.notiMessage = notiMessage
        self.getUserName = getUserName
        self.sendUserId = sendUserId
    }
    
    
}
