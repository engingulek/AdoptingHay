//
//  ChatVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 11.12.2021.
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

class ChatVC: MessagesViewController {
    private var messages = [Message]()
    private var selfSender:Sender!
    private var sendSender:Sender!
    private var messageCount:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
     
       
        getAllMessage()
       
    }
    
    func getAllMessage() {
        let db = Firestore.firestore()
    
        
        if let authUserID = Auth.auth().currentUser?.uid {
            
            db.collection("userList").document(authUserID).collection("conversation").getDocuments { snasphot, error in
                if error != nil {
                    print("Message getAll error \(error?.localizedDescription)")
                }
                
                else {
                    
                    for document in (snasphot?.documents)! {
                        print("Messsge sender id : \(document.documentID)")
                        if let messageSenderName = document.get("kullanıcıName") as? String {
                            print("Message sender name \(messageSenderName)")
                            
                            if let message = document.get("message") as? [Any]
                            {
                                self.messageCount = 2
                                
                                for i in 0...message.count-1 {
                                    print("\(i). sıra \(message[i])")
                                    
                                    if let messageOrder = message[i] as? [String:Any] {
                                        
                                        
                                        
                                        if let gonderilenMessage = messageOrder["gonderilenMessage"] as? String {
                                            
                                            if let sendUserID = messageOrder["senderId"] as? String {
                                                if sendUserID != authUserID {
                                                    self.sendSender = Sender(senderId: "2", displayName: "Selin Çiçek" )
                                                    
                                                    self.messages.append(Message(sender: self.sendSender, messageId: "2", sentDate: Date(), kind: .text("Merhaba")))
                                                    print("Gönderen Id : \(sendUserID) mesaj => \(gonderilenMessage)")
                                                }
                                                else {
                                                    self.selfSender = Sender(senderId: "1", displayName: "Engin Gülek")

                                                    
                                                //    self.messages.append(Message(sender: self.selfSender, messageId: "1", sentDate: Date(), kind: .text("Merhaba")))
                                                    
                                                    print("Gönderen Id : \(sendUserID) mesaj => \(gonderilenMessage)")
                                                    
                                                }
                                            }
                                            
                                        }
                                    }
                                
                                    
                                
                                    
                                    
                                }
                      
                                    
                                }
                            }
                        }
                        
                        
                    }
                }
            }
            
        }
        
        
    }
    
    
    
    
    
    
    




extension ChatVC : InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
     
        
        print("\(text)")
      
    }
}







extension ChatVC :  MessagesDataSource ,MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> SenderType {
      return selfSender!
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        print("Message sayi \(messages.count)")
        return 2
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = message.sender
        if sender.senderId == selfSender!.senderId {
            // our image
            avatarView.image = UIImage(named: "bird")
        }
        else {
            avatarView.image = UIImage(named: "dog")
        }
    }
}
