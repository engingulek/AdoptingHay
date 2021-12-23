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


struct DogMessage : MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
}


struct DogSender:SenderType {
   
    var senderId: String
    var displayName: String
    
    
    
    
    
}

class DogChatVC: MessagesViewController {
    private var messages = [Message]()
    var userId:String?
    private var selfSender = Sender(senderId: "1", displayName: "Engin Gülek")
    private var sendSender = Sender(senderId: "2", displayName: "Selin Çiçek")
    var messageViewModelList : MessageViewModelList!
    var timer = Timer()
    var  messageGetUserName : String?
    var senderName:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self

        
    }
    

   

}



extension DogChatVC : InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        print("\(text)")
        
    }
    
}


extension DogChatVC :  MessagesDataSource ,MessagesLayoutDelegate, MessagesDisplayDelegate {
   
    
    func currentSender() -> SenderType {
      return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
       
        return  messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        print("Message sayi \(messages.count)")
        return messages.count
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = message.sender
        if sender.senderId == selfSender.senderId {
            // our image
            avatarView.image = UIImage(named: "red")
        }
        else {
            avatarView.image = UIImage(named: "blue")
        }
    }
    
    
}
