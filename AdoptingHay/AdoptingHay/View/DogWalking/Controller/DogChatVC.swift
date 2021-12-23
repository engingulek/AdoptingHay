//
//  DogChatVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 23.12.2021.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Firebase


struct Message : MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
}


struct Sender:SenderType {
    var senderId: String
    var displayName: String
    
    
    
    
    
}

class DogChatVC: MessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
    }
    

   

}
