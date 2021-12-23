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
import Kingfisher


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

struct Media:MediaItem {
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
    
    
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
    var sendToGetMessageDataChat:[String:Any]?
    let imagepicker = UIImagePickerController()
    let sendImage:UIImageView? = nil
  

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        setupInputButton()
        
        
        
        
        
        
        
        
//        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .photo(Media(url: nil, image: UIImage(named:"pp"), placeholderImage: UIImage(named:"pp")!, size: CGSize(width: 250, height: 150)))))
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        self.getAllMessageData()
                self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats:  true, block: {_ in
                    self.getAllMessageData()
                })
    

        
    }
    
    
  private func setupInputButton() {
       let button = InputBarButtonItem()
       button.setSize(CGSize(width: 35, height: 35), animated: false)
       button.setImage(UIImage(systemName: "paperclip"), for: .normal)
       button.onTouchUpInside { [weak self] _ in
           self?.presentInputActionSheet()
       }
       messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
       messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
   }
    
    private func presentInputActionSheet() {
        let actionSheet = UIAlertController(title: "Medya Ekle",
                                            message: "Ne eklemek istersiniz?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Resim", style: .default, handler: { action in
            
            self.imagepicker.delegate = self
            self.imagepicker.sourceType = .photoLibrary
            self.present(self.imagepicker, animated: true, completion: nil)
         
            
        }))
       
        actionSheet.addAction(UIAlertAction(title: "Lokasyon", style: .default, handler: { [weak self]  _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(actionSheet, animated: true)
    }
    
    
    
    func ada(document:QueryDocumentSnapshot,id:String){
        let db = Firestore.firestore()
        
          if id == document.documentID {
              if let messageSenderName = document.get("getUserName") as? String {
                                          print("Message sender name \(messageSenderName)")
                  self.messageGetUserName = messageSenderName
                                          self.navigationItem.title = messageSenderName
                                          
                                          if let message = document.get("message") as? [Any]
                                          {
                                              
                                          
                                              
                                              for i in 0...message.count-1 {
                                                  print("\(i). sıra \(message[i])")
                                                  
                                                  if let messageOrder = message[i] as? [String:Any] {
                                                      
                                                      
                                                      
                                                      if let gonderilenMessage = messageOrder["sendMessage"] as? String {
                                                          
                                                          if let sendImage = messageOrder["sendImage"] as? String {
                                                              if let sendUserID = messageOrder["senderId"] as? String {
                                                                  
                                                                  print("USER ID : \(Auth.auth().currentUser?.uid)")
                                                                  
                                                                  if let userId = Auth.auth().currentUser?.uid as? String {
                                                                      if userId == sendUserID {
                                                                       
                                                                          
                                                                          if gonderilenMessage == "" {
                                                                             
                                                                              let imageUrl = URL(string:sendImage)!
                                                                              
                                                                              let myImage:UIImageView = UIImageView()
                                                                              
                                                                              myImage.kf.setImage(with: URL(string:sendImage), placeholder: nil, options:[.transition(.fade(0.7))], completionHandler: nil)
                                                                              self.messages.append(Message(sender: self.selfSender, messageId: "2", sentDate: Date(), kind: .photo(Media(url: nil, image: myImage.image, placeholderImage: UIImage(systemName:"ellipsis")!, size: CGSize(width: 250, height: 150)))))
                                                                              
                                                                          
                                                                              
                                                                             
//
                                                                          }
                                                                                                                                                                     else {
                                                                              self.messages.append(Message(sender: self.selfSender, messageId: "1", sentDate: Date(), kind: .text(gonderilenMessage)))
                                                                              
                                                                       }
                                                                        
                                                                     
                                                                          
                                                                          
                                                                          
                                                                      }
                                                                      else {
                                                                          
                                                                          if gonderilenMessage == "" {
//                                                                                                 let imageUrl = URL(string:sendImage)!
                                                                              
                                                                              let myImage:UIImageView = UIImageView()
                                                                              
                                                                              myImage.kf.setImage(with: URL(string:sendImage), placeholder: nil, options:[.transition(.fade(0.7))], completionHandler: nil)
                                                                              self.messages.append(Message(sender: self.sendSender, messageId: "2", sentDate: Date(), kind: .photo(Media(url: nil, image: myImage.image, placeholderImage: UIImage(systemName:"ellipsis")!, size: CGSize(width: 250, height: 150)))))
                                                                              

                                                                          }
                                                                          
                                                                         else {
                                                                              self.messages.append(Message(sender: self.sendSender, messageId: "2", sentDate: Date(), kind: .text(gonderilenMessage)))
                                                                              
                                                                    }
                                                                          
                                                                         
                                                                          
                                                                      }
                                                                      self.messagesCollectionView.reloadData()
                                                                     
                                                                      
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
    
    func getAllMessageData() {
        self.messages.removeAll()
        let db = Firestore.firestore()
    
        
        if let authUserID = Auth.auth().currentUser?.uid {
            
            db.collection("userList").document(authUserID).collection("dogWalkingConversation").getDocuments { snasphot, error in
                if error != nil {
                    print("Message getAll error \(error?.localizedDescription)")
                }
                
                else {
                   
                    
                    
                    for document in (snasphot?.documents)! {
                        
                       
                        
                        
                        if let sendUserId = self.userId {
                            self.ada(document: document, id: sendUserId)
                          
                            }
                        
                        
                        else {
                            if let senderUserId = self.sendToGetMessageDataChat!["messageGetUserId"] as? String {

                                self.ada(document: document, id: senderUserId)


                            }
                        }

                        }
                        
                        
                    }
                }
            }

        
    }

   

}


extension DogChatVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) {

            let myImageView:UIImageView = UIImageView()
           
            myImageView.image = info[.originalImage] as? UIImage
        
            
           
            let storage = Storage.storage()
            let storageReferance = storage.reference()
            let medinaFolder = storageReferance.child("media")
            
            if let imageData = myImageView.image?.jpegData(compressionQuality: 0.5)
             {
                let imageDataUuid = UUID().uuidString
                let imageReferance = medinaFolder.child("\(imageDataUuid).jpeg")
                imageReferance.putData(imageData, metadata: nil) { metaData, error in
                    if error == nil {
                        imageReferance.downloadURL { url, error in
                            let imagedUrl = url?.absoluteString
                            if let imagedUrl = imagedUrl {
                                if let sendUserId = self.userId as? String {
                                   
                                    
                                    self.messagesCollectionView.reloadData()
                                    if let sendUserName = Auth.auth().currentUser?.displayName as? String {
                                    
                                                        DogWalkingService().sendMessage(sendUserId: sendUserId , sendUserName: sendUserName, sendMessage: "",getUserName:self.messageGetUserName!,sendImage: imagedUrl)
                                   
                                        
                                        
                                    }
                                    
                                
                                }
                                else {
                                    


                                    if let senduserid = self.sendToGetMessageDataChat!["messageGetUserId"] as? String {
                                      
                                        self.messagesCollectionView.reloadData()
                                        if let sendUserName =  Auth.auth().currentUser?.displayName as? String {
                                            
                                            if let messageGetuserName = self.sendToGetMessageDataChat!["messageGetUserName"] as? String {
                                                
                                                DogWalkingService().sendMessage(sendUserId: senduserid , sendUserName: sendUserName, sendMessage: "",getUserName: messageGetuserName,sendImage: imagedUrl)
                                    
                                                
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


extension DogChatVC : InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        if let sendUserId = userId as? String {
           
         
            self.messagesCollectionView.reloadData()
            if let sendUserName = Auth.auth().currentUser?.displayName as? String {
            
                                DogWalkingService().sendMessage(sendUserId: sendUserId , sendUserName: sendUserName, sendMessage: text,getUserName:self.messageGetUserName!,sendImage: "")
               inputBar.inputTextView.text = ""
                
                
            }
            
        
        }
        else {
            


            if let senduserid = self.sendToGetMessageDataChat!["messageGetUserId"] as? String {
              
                self.messagesCollectionView.reloadData()
                if let sendUserName =  Auth.auth().currentUser?.displayName as? String {
                    
                    if let messageGetuserName = self.sendToGetMessageDataChat!["messageGetUserName"] as? String {
                        
                        DogWalkingService().sendMessage(sendUserId: senduserid , sendUserName: sendUserName, sendMessage: text,getUserName: messageGetuserName,sendImage: "")
            inputBar.inputTextView.text = ""
                        
                    }
                    
        
                    
                    
                }
 
                
            }
            
            
            
 
            
        }
        
        
        
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
