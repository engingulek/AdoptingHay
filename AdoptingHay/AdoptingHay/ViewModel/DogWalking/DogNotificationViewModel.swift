//
//  DogNotificationViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 22.12.2021.
//

import Foundation



struct DogNotificationViewModelList {
    var dogNotificationList : [DogNotification]
    
    func dogNotificationListCount() -> Int {
        return dogNotificationList.count
    }
    
    func dogNotificationAtIndex(_ index:Int) -> DogNotificationViewModel {
        let notification = dogNotificationList[index]
        
        return DogNotificationViewModel(dogNotification: notification)
        
    }
}


struct DogNotificationViewModel {
    let dogNotification : DogNotification
    
    var notiId: String {
        return dogNotification.notiId!
    }
    
    var sendUserName : String {
        return dogNotification.sendUserName!
    }
    
    var title : String {
        return dogNotification.notiTitle!
    }
    
    var subtitle : String {
        return dogNotification.notiSubtitle!
    }
    
    var message : String {
        return dogNotification.notiMessage!
    }
    
    var getUserName : String {
        return dogNotification.getUserName!
    }
    
    var sendUserId:String {
        return dogNotification.sendUserId!
    }
}
