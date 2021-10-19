//
//  Notification.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.10.2021.
//

import Foundation

class Notification {
    var id:Int?
    var notificationImage:String?
    var notificationName:String?
    var notificationNoti:String?
    
    init() {
        
    }
    
    
    init(id:Int,notificationImage:String,notificationName:String,notificationNoti:String) {
        self.id = id
        self.notificationImage = notificationImage
        self.notificationName = notificationName
        self.notificationNoti = notificationNoti
    }
    
}
