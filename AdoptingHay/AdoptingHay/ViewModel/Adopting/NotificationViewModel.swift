//
//  NotificationViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 11.12.2021.
//

import Foundation

struct NotificationListViewModel {
    var notiList : [Notification]
    
    
    func numberOfRowsInSection()-> Int {
        return self.notiList.count
    }
    
    
   func animalAdvertAtIndex(_ index:Int) ->
    NotificationViewModel {
        let noti = self.notiList[index]
        return NotificationViewModel(notification: noti)
        
      
    }
}


struct NotificationViewModel {
    let notification : Notification
    
    var getUserId:String{
        return self.notification.getUserId!
    }
    
    var message : String {
        return self.notification.sendMessage!
    }
    
    var subtitle: String {
        return self.notification.sendNotiSubtitle!
    }
    
    var title : String {
        return self.notification.sendNotiTitle!
    }
    
    var sendName : String {
        return self.notification.sendUserName!
    }
    
    var notiId : String {
        return self.notification.notiId!
    }
    
    
    
}
