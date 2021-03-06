//
//  DogWalkingService.swift
//  AdoptingHay
//
//  Created by engin gülek on 18.12.2021.
//

import Foundation
import Firebase
class DogWalkingService {
    var dogWalkingAdvertList = [DogwalkingAdvert]()
    var inComingRequestList = [Request]()
    var dogMyAdvertList = [DogMyAdvert]()
    var dogFavList = [DogFavAdvert]()
    var dogNotiList = [DogNotification]()
    var messageUserList = [MessageUserList]()
    var commentList = [Comment]()
    var accountComments = [Comment]()
    var Ascore:Int = 0;
    // ilanların alınması
    func geDogWalkingAdvert(completion: @escaping ([DogwalkingAdvert]?)->()){
        let db = Firestore.firestore()
        
        db.collection("dogWalkingAdvert").getDocuments { snapshot, error in
            if error != nil{
                completion(nil)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let advertId = document.documentID as? String {
                        
                        if let animalName = document.get("animalName") as? String {
                            if let animalKindsAge = document.get("ageAndGenus") as? String {
                                if let hoursRange = document.get("timeRange") as? Int {
                                    
                                    if let sickInfo = document.get("sickInfo") as? String {
                                        
                                        if let animalImage = document.get("animalImage") as? String {
                                            
                                            if let ownerNote = document.get("ownerNote") as? String {
                                                if let sickBool = document.get("sickBool") as? String {
                                                    if let userName = document.get("userName") as? String {
                                                        if let userId = document.get("userId") as? String {
                                                            if let situation = document.get("situation") as? String{
                                                                if situation == "Aktif" {
                                                                    let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                    let dogWalkingAdvert = DogwalkingAdvert(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool,ownerNote: ownerNote,sickInfo: sickInfo,userId: userId,userName: userName,dateEvent: a,situation: situation)
                                                                    self.dogWalkingAdvertList.append(dogWalkingAdvert)
                                                                    completion(self.dogWalkingAdvertList)
                                                                    
                                                                }
                                                                
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                    
                                                } } }}} }}}}}}}
    
    
    
    // favori liste ekleme işlemi
    func addDogWalkingAdvert(getAdvert:DogwalkingAdvert) {
        let db = Firestore.firestore()
        let docData : [String:Any] = [
            "animalImage" : getAdvert.advertImage!,
            "animalName" : getAdvert.advertAnimalName!,
            "timeRange": getAdvert.advertRange!,
            "sickBool" : getAdvert.advertAnimalSick!,
            "ageAndGenus" : getAdvert.advertAnimalKindsandAge!,
            "ownerNote" : getAdvert.ownerNote!,
            "sickInfo":getAdvert.sickInfo!,
            "userName" : getAdvert.userName!,
            "userId" : getAdvert.userId!,
            "situation" : getAdvert.situation!
            
            
            
        ]
        
        if let userId = Auth.auth().currentUser?.uid {
            
            db.collection("userList").document(userId).collection("dogWalklingFavoriList").document(getAdvert.advertId!).setData(docData)
            
            
            
            
        }
        
        
    }
    
    // ilan ekleme
    func addDogWalkingAdvertToFirebase(advert:DogWalkAddAdvert){
        let db = Firestore.firestore()
        if let userId = Auth.auth().currentUser?.uid {
            if let userName = Auth.auth().currentUser?.displayName {
                let docData : [String:Any] = [
                    "userId" : userId,
                    "userName" : userName,
                    "animalName" : advert.animalName!,
                    "ageAndGenus" : advert.ageAndGenus!,
                    "sickInfo" : advert.sickInfo!,
                    "sickBool" : advert.sickBool!,
                    "ownerNote" : advert.ownerNote!,
                    "animalImage" : advert.addImage!,
                    "date" : advert.time!,
                    "timeRange" : advert.timeRange!,
                    "situation" : "Aktif"
                    
                ]
                
                let advertId = UUID()
                
                db.collection("dogWalkingAdvert").document("\(advertId)").setData(docData)
                db.collection("userList").document(userId).collection("dogWalkingAdvert").document("\(advertId)").setData(docData)
                
            }
            
            
        }
        
        
        
    }
    
    
    // Favori ilanlarının alınması
    func dowloandDogWalkingFavList(completion: @escaping ([DogFavAdvert]?)->()){
        
        let db = Firestore.firestore()
        if let authId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authId).collection("dogWalklingFavoriList").getDocuments { snapshot, error in
                if error != nil{
                    completion(nil)
                }
                else {
                    for document in (snapshot?.documents)! {
                        if let advertId = document.documentID as? String {
                            
                            if let animalName = document.get("animalName") as? String {
                                if let animalKindsAge = document.get("ageAndGenus") as? String {
                                    if let hoursRange = document.get("timeRange") as? Int {
                                        
                                        if let sickInfo = document.get("sickInfo") as? String {
                                            
                                            if let animalImage = document.get("animalImage") as? String {
                                                
                                                if let ownerNote = document.get("ownerNote") as? String {
                                                    if let sickBool = document.get("sickBool") as? String {
                                                        if let userName = document.get("userName") as? String {
                                                            if let userId = document.get("userId") as? String {
                                                                if let situation = document.get("situation") as? String {
                                                                    if situation == "Aktif" {
                                                                        let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                        
                                                                        let advert = DogFavAdvert(userId: userId, userName: userName, animalImage: animalImage, time: a, timeRange: hoursRange, animalName: animalName, ageAndGenus: animalKindsAge, sickBool: sickBool, sickInfo: sickInfo, ownerNote: ownerNote, advertId: advertId,situation: situation)
                                                                        self.dogFavList.append(advert)
                                                                        completion(self.dogFavList)
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                                
                                                            }
                                                        }
                                                        
                                                        
                                                    } } }}} }}}}}}
            
        }
        
        
        
        
    }
    
    // favoriden ilan kaldırma
    func removeFavoriAdvert(advertId:String) {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        
        
        if let userId = userId {
            db.collection("userList").document(userId).collection("dogWalklingFavoriList").document(advertId).delete()}}
    
    // kendi ilanını silme
    func removeMyAdvert(advertId:String) {
        let db = Firestore.firestore()
        let userId = Auth.auth().currentUser?.uid
        
        
        if let userId = userId {
            db.collection("userList").document(userId).collection("dogWalkingAdvert").document(advertId).delete()
            db.collection("dogWalkingAdvert").document(advertId).delete()
            
            
        }
        
        
    }
    
    
    // kendi ilanların alınması
    func dowlondDogMyAdvert(completion: @escaping ([DogMyAdvert]?)->()){
        let db = Firestore.firestore()
        if let authId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authId).collection("dogWalkingAdvert").getDocuments { snapshot, error in
                if error != nil{
                    completion(nil)
                }
                else {
                    for document in (snapshot?.documents)! {
                        if let advertId = document.documentID as? String {
                            
                            if let animalName = document.get("animalName") as? String {
                                if let animalGenusAge = document.get("ageAndGenus") as? String {
                                    if let hoursRange = document.get("timeRange") as? Int{
                                        
                                        if let sickInfo = document.get("sickInfo") as? String {
                                            
                                            if let animalImage = document.get("animalImage") as? String {
                                                
                                                if let ownerNote = document.get("ownerNote") as? String {
                                                    if let sickBool = document.get("sickBool") as? String {
                                                        if let userName = document.get("userName") as? String {
                                                            if let userId = document.get("userId") as? String {
                                                                
                                                                if let situation = document.get("situation") as? String {
                                                                    let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                    
                                                                    if situation == "Aktif" {
                                                                        let myAdvert =  DogMyAdvert(userId: userId, userName: userName, animalImage: animalImage, time: a, timeRange: hoursRange, animalName: animalName, ageAndGenus: animalGenusAge, sickBool: sickBool, sickInfo: sickInfo, ownerNote: ownerNote, advertId: advertId,situation: situation)
                                                                        
                                                                        self.dogMyAdvertList.append(myAdvert)
                                                                        completion(self.dogMyAdvertList)
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                    
                                                                }
                                                                
                                                                
                                                                
                                                                
                                                            }
                                                            
                                                            
                                                        }
                                                    }
                                                    
                                                    
                                                } } }}} }}}}}
            
        }
        
        
    }
    
    // kendi ilanını güncelleme
    func updateMyDogAdvert(userId:String,advertId:String,updateData:[String:Any]) {
        let db = Firestore.firestore()
        db.collection("userList").document(userId).collection("dogWalkingAdvert").document(advertId).updateData(updateData)
        db.collection("dogWalkingAdvert").document("\(advertId)").updateData(updateData)
        
    }
    
    
    //MARK: Filtering Operations
    
    /// Tarih filtreleme
    func dateFilter(filterType:Bool,completion: @escaping ([DogwalkingAdvert]?)->()) {
        let db = Firestore.firestore()
        db.collection("dogWalkingAdvert").order(by: "date",descending: filterType).getDocuments { snapshot, error in
            if error != nil{
                completion(nil)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let advertId = document.documentID as? String {
                        
                        if let animalName = document.get("animalName") as? String {
                            if let animalKindsAge = document.get("ageAndGenus") as? String {
                                if let hoursRange = document.get("timeRange") as? Int {
                                    
                                    if let sickInfo = document.get("sickInfo") as? String {
                                        
                                        if let animalImage = document.get("animalImage") as? String {
                                            
                                            if let ownerNote = document.get("ownerNote") as? String {
                                                if let sickBool = document.get("sickBool") as? String {
                                                    if let userName = document.get("userName") as? String {
                                                        if let userId = document.get("userId") as? String {
                                                            if let situation = document.get("situation") as? String{
                                                                let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                let dogWalkingAdvert = DogwalkingAdvert(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool,ownerNote: ownerNote,sickInfo: sickInfo,userId: userId,userName: userName,dateEvent: a,situation: situation)
                                                                self.dogWalkingAdvertList.append(dogWalkingAdvert)
                                                                completion(self.dogWalkingAdvertList)
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                    
                                                } } }}} }}}}}
            
            
        }
        
    }
    /// zaman filtreleme
    func timeFilter(filterType:Bool,completion: @escaping ([DogwalkingAdvert]?)->()) {
        let db = Firestore.firestore()
        db.collection("dogWalkingAdvert").order(by: "timeRange",descending: filterType).getDocuments { snapshot, error in
            if error != nil{
                completion(nil)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let advertId = document.documentID as? String {
                        
                        if let animalName = document.get("animalName") as? String {
                            if let animalKindsAge = document.get("ageAndGenus") as? String {
                                if let hoursRange = document.get("timeRange") as? Int {
                                    
                                    if let sickInfo = document.get("sickInfo") as? String {
                                        
                                        if let animalImage = document.get("animalImage") as? String {
                                            
                                            if let ownerNote = document.get("ownerNote") as? String {
                                                if let sickBool = document.get("sickBool") as? String {
                                                    if let userName = document.get("userName") as? String {
                                                        if let userId = document.get("userId") as? String {
                                                            if let situation = document.get("situation") as? String{
                                                                let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                let dogWalkingAdvert = DogwalkingAdvert(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool,ownerNote: ownerNote,sickInfo: sickInfo,userId: userId,userName: userName,dateEvent: a,situation: situation)
                                                                self.dogWalkingAdvertList.append(dogWalkingAdvert)
                                                                completion(self.dogWalkingAdvertList)
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                    
                                                } } }}} }}}}}
            
            
        }
        
    }
    /// hastalık filtreleme
    func sickFilter(sickBool:String,completion: @escaping ([DogwalkingAdvert]?)->()) {
        let db = Firestore.firestore()
        
        db.collection("dogWalkingAdvert").whereField("sickBool", isEqualTo: sickBool).getDocuments { snapshot, error in
            if error != nil{
                completion(nil)
            }
            else {
                for document in (snapshot?.documents)! {
                    if let advertId = document.documentID as? String {
                        
                        if let animalName = document.get("animalName") as? String {
                            if let animalKindsAge = document.get("ageAndGenus") as? String {
                                if let hoursRange = document.get("timeRange") as? Int {
                                    
                                    if let sickInfo = document.get("sickInfo") as? String {
                                        
                                        if let animalImage = document.get("animalImage") as? String {
                                            
                                            if let ownerNote = document.get("ownerNote") as? String {
                                                if let sickBool = document.get("sickBool") as? String {
                                                    if let userName = document.get("userName") as? String {
                                                        if let userId = document.get("userId") as? String {
                                                            if let situation = document.get("situation") as? String {
                                                                let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                let dogWalkingAdvert = DogwalkingAdvert(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool,ownerNote: ownerNote,sickInfo: sickInfo,userId: userId,userName: userName,dateEvent: a,situation: situation)
                                                                self.dogWalkingAdvertList.append(dogWalkingAdvert)
                                                                completion(self.dogWalkingAdvertList)
                                                            }
                                                            
                                                        }
                                                    }
                                                    
                                                    
                                                } } }}} }}}}}
            
        }
        
        
        
    }
    // bildirimlerim gönderme
    func addDogWalkingAdvertNoti(notiData:[String:Any],getUserId:String) {
        let db = Firestore.firestore()
        if let authId = Auth.auth().currentUser?.uid {
           
            let notiId = UUID().uuidString
            db.collection("userList").document(getUserId).collection("dogWalkingNoti").document("\(notiId)").setData(notiData)
           
        }
    }
    
    
    // bildirimlerin alınması
    
    func getAllDogWalkingNotifromFirebase(completion:@escaping([DogNotification]?)->()){
        
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
           
            db.collection("userList").document(authUserId).collection("dogWalkingNoti").getDocuments { snapshot, error in
                
               
                for document in (snapshot?.documents)! {
                    if let notiId = document.documentID as? String {

                            if let  getUserId = document.get("getUserId") as? String {

                                if let  getUserName = document.get("getUserName") as? String {

                                    if let  notiTitle = document.get("notiTitle") as? String {

                                        if let  notiSubtitle = document.get("notiSubtitle") as? String {

                                            if let  notiMessage = document.get("notiMessage") as? String {

                                                if let  sendUserName = document.get("sendUserName") as? String {

                                                    if let sendUserId = document.get("sendUserId") as? String {
                                                        let noti = DogNotification(notiId: notiId, sendUserName: sendUserName, notiTitle: notiTitle, notiSubtitle: notiSubtitle, notiMessage: notiMessage, getUserName: getUserName,sendUserId: sendUserId)

                                                        self.dogNotiList.append(noti)

                                                        completion(self.dogNotiList)
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
            
            
//            db.collection("userList").document(authUserId).collection("dogWalkingNoti").getDocuments { snapshot, error in
//
//                if error != nil {
//                    completion(nil)
//                }
//
//                else {
//                    for document in (snapshot?.documents)! {
//
//                        if let notiId = document.documentID as? String {
//
//                            if let  getUserId = document.get("getUserId") as? String {
//
//                                if let  getUserName = document.get("getUserName") as? String {
//
//                                    if let  notiTitle = document.get("notiTitle") as? String {
//
//                                        if let  notiSubtitle = document.get("notiSubtitle") as? String {
//
//                                            if let  notiMessage = document.get("notiMessage") as? String {
//
//                                                if let  sendUserName = document.get("sendUserName") as? String {
//
//                                                    let noti = DogNotification(notiId: notiId, sendUserName: sendUserName, notiTitle: notiTitle, notiSubtitle: notiSubtitle, notiMessage: notiMessage, getUserName: getUserName)
//
//                                                    self.dogNotiList.append(noti)
//
//                                                    completion(self.dogNotiList)
//
//                                                }
//
//                                            }
//                                        }
//
//                                    }
//
//                                }
//
//                            }
//
//
//
//                        }
//                    }
//                }
//            }
            
        }
        
        
    }
    
    // Bildirim silme
    func removeDogWalkingAdvertNoti(notiId:String) {
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authUserId).collection("dogWalkingNoti").document(notiId).delete()
            
        }
        db.collection("userList")
    }
    // mesaj gönderme
    func sendMessage(sendUserId:String,sendUserName:String,sendMessage:String,getUserName:String,sendImage:String) {
        
        
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            let myDb = db.collection("userList").document(authUserId).collection("dogWalkingConversation").document(sendUserId)
            let orderDb =  db.collection("userList").document(sendUserId).collection("dogWalkingConversation").document(authUserId)
            
            
            myDb.getDocument { mysnaphot, error in
                
                orderDb.getDocument { orderSnaphot, error in
                    if  mysnaphot?.get("message") != nil && orderSnaphot?.get("message") == nil  {
                        let message : [String:Any] = [
                            "date":Date(),
                            "sendMessage":sendMessage ?? "",
                            "senderId": authUserId,
                            "sendImage" : sendImage
                        ]
                        if let getUserName = getUserName as? String{
                            let getMessageData : [String:Any] = [
                                "sendUserName" : getUserName,
                                "getUserName"  : sendUserName,
                                "message": [message]
                            ]
                            db.collection("userList").document(sendUserId).collection("dogWalkingConversation").document(authUserId).setData(getMessageData)
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            
            
            
            
            
            
            
            
            
            
            db.collection("userList").document(authUserId).collection("dogWalkingConversation").document(sendUserId).getDocument { snapshot, error in
                
                if  snapshot?.get("message") == nil  {
                    
                    let message : [String:Any] = [
                        "date":Date(),
                        "sendMessage":sendMessage,
                        "senderId": authUserId,
                        "sendImage" : sendImage
                    ]
                    
                    
                    
                    
                    if let getUserName = getUserName as? String{
                        
                        
                        
                        let sendMessageData : [String:Any] = [
                            "sendUserName" : sendUserName,
                            "getUserName"  : getUserName,
                            "message": [message]
                        ]
                        
                        
                        let getMessageData : [String:Any] = [
                            "sendUserName" : getUserName,
                            "getUserName"  : sendUserName,
                            "message": [message]
                        ]
                        
                        
                        
                        
                        
                        db.collection("userList").document(authUserId).collection("dogWalkingConversation").document(sendUserId).setData(sendMessageData)
                        
                        db.collection("userList").document(sendUserId).collection("dogWalkingConversation").document(authUserId).setData(getMessageData)
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
                
                
                
                else {
                    let message : [String:Any] = [
                        "date":Date(),
                        "sendMessage":sendMessage,
                        "senderId": authUserId,
                        "sendImage" : sendImage
                    ]
                    
                    
                    db.collection("userList").document(authUserId).collection("dogWalkingConversation").document(sendUserId).updateData([
                        "message": FieldValue.arrayUnion([message])
                    ])
                    
                    
                    db.collection("userList").document(sendUserId).collection("dogWalkingConversation").document(authUserId).updateData([
                        "message": FieldValue.arrayUnion([message])
                    ])
                    
                }
                
            }
        }
        
        
    }
    
    
    // Bütün mesajların silinmesi
    func getAllMessageList(completion: @escaping ([MessageUserList]?)->()){
        
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authUserId).collection("dogWalkingConversation").getDocuments { snapshot, error in
                if error != nil {
                    print("Message User List Error \(error?.localizedDescription)")
                }
                else {
                    for document in (snapshot?.documents)! {
                        print("dffd ")
                        if let userId  = document.documentID as? String {
                            if let getUserName = document.get("getUserName") as? String {
                                let messageUser = MessageUserList(sendName: getUserName, sendUserId: userId)
                                self.messageUserList.append(messageUser)
                                completion(self.messageUserList)
                            }}}} }}}
    
    //mesaj silme
    func deleteMessage(id:String){
        print("Mesaj id si :\(id)")
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authUserId).collection("dogWalkingConversation").document(id).delete()
            
        }
    }
    
    // istek gönderme
    func sendRequest(getAdvert:DogwalkingAdvert) {
        let db = Firestore.firestore()
        
        
        
        
        // add to advert's owner request list
        
        if let userId = Auth.auth().currentUser?.uid {
            if let authUserName = Auth.auth().currentUser?.displayName {
                let docData : [String:Any] = [
                    "animalImage" : getAdvert.advertImage!,
                    "animalName" : getAdvert.advertAnimalName!,
                    "timeRange": getAdvert.advertRange!,
                    "sickBool" : getAdvert.advertAnimalSick!,
                    "ageAndGenus" : getAdvert.advertAnimalKindsandAge!,
                    "ownerNote" : getAdvert.ownerNote!,
                    "sickInfo":getAdvert.sickInfo!,
                    "userName" : getAdvert.userName!,
                    "userId" : getAdvert.userId!,
                    "situation" : getAdvert.situation!,
                    "date" : getAdvert.dateEvent!,
                    "sendRequestId" : userId,
                    "acceptAdvertUserName" : authUserName
                ]
                db.collection("userList").document(getAdvert.userId!).collection("incomingRequest").document(getAdvert.advertId!).setData(docData)
                db.collection("userList").document(userId).collection("isentRequest").document(getAdvert.advertId!).setData(docData)
            }
            
            
          
         
        } }
    
    
    func getInComingRequestList(completion: @escaping ([Request]?)->()){
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            if let authId = Auth.auth().currentUser?.uid {
                db.collection("userList").document(authId).collection("incomingRequest").getDocuments { snapshot, error in
                    if error != nil{
                        completion(nil)
                    }
                    else {
                        for document in (snapshot?.documents)! {
                            if let advertId = document.documentID as? String {
                                
                                if let animalName = document.get("animalName") as? String {
                                    if let animalKindsAge = document.get("ageAndGenus") as? String {
                                        if let hoursRange = document.get("timeRange") as? Int {
                                            
                                            if let sickInfo = document.get("sickInfo") as? String {
                                                
                                                if let animalImage = document.get("animalImage") as? String {
                                                    
                                                    if let ownerNote = document.get("ownerNote") as? String {
                                                        if let sickBool = document.get("sickBool") as? String {
                                                            if let userName = document.get("userName") as? String {
                                                                if let userId = document.get("userId") as? String {
                                                                    if let situation = document.get("situation") as? String {
                                                                        if let sendRequestId = document.get("sendRequestId") as? String {
                                                                            if situation == "Aktif" {
                                                                                if let acceptUserName = document.get("acceptAdvertUserName") as? String {
                                                                                    let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                                    let inComingAdvert = Request(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool, ownerNote: ownerNote, sickInfo: sickInfo, userId: userId, userName: userName, dateEvent: a, situation: situation, sendId: sendRequestId,acceptUserName: acceptUserName)
                                                                                    self.inComingRequestList.append(inComingAdvert)
                                                                                    completion(self.inComingRequestList)
                                                                                }
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                            }
                                                                        }
                                                                        
                                                                        
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                }
                                                            }
                                                            
                                                            
                                                        } } }}} }}}}}}
                
            }
            
        }
        
        
        
    }
    
    
    
    // isteğin alınması
    func isendRequestList(completion: @escaping ([Request]?)->()){
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            if let authId = Auth.auth().currentUser?.uid {
                db.collection("userList").document(authId).collection("isentRequest").getDocuments { snapshot, error in
                    if error != nil{
                        completion(nil)
                    }
                    else {
                        for document in (snapshot?.documents)! {
                            if let advertId = document.documentID as? String {
                                
                                if let animalName = document.get("animalName") as? String {
                                    if let animalKindsAge = document.get("ageAndGenus") as? String {
                                        if let hoursRange = document.get("timeRange") as? Int {
                                            
                                            if let sickInfo = document.get("sickInfo") as? String {
                                                
                                                if let animalImage = document.get("animalImage") as? String {
                                                    
                                                    if let ownerNote = document.get("ownerNote") as? String {
                                                        if let sickBool = document.get("sickBool") as? String {
                                                            if let userName = document.get("userName") as? String {
                                                                if let userId = document.get("userId") as? String {
                                                                    if let situation = document.get("situation") as? String {
                                                                        if let sendRequestId = document.get("sendRequestId") as? String {
                                                                            if situation == "Aktif" {
                                                                                if let acceptUserName = document.get("acceptAdvertUserName") as? String {
                                                                                    let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                                    let inComingAdvert = Request(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool, ownerNote: ownerNote, sickInfo: sickInfo, userId: userId, userName: userName, dateEvent: a, situation: situation, sendId: sendRequestId,acceptUserName: acceptUserName)
                                                                                    self.inComingRequestList.append(inComingAdvert)
                                                                                    completion(self.inComingRequestList)
                                                                                    
                                                                                    
                                                                                    
                                                                                }
                                                                                
                                                                                
                                                                                
                                                                                
                                                                        
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                            }
                                                                        }
                                                                        
                                                                        
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                }
                                                            }
                                                            
                                                            
                                                        } } }}} }}}}}}
                
            }
            
        }
        
        
        
    }
    
    
    
   // gönderilen isteği kaldırma
    func removeISendRequest(id:String,advertOwnerUserId:String){
        
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authUserId).collection("isentRequest").document(id).delete()
            db.collection("userList").document(advertOwnerUserId).collection("incomingRequest").document(id).delete()
            
        }
    }
    
    // gelen isteği silme
    func removeComingRequest(id:String,sendUserId:String){
        
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authUserId).collection("incomingRequest").document(id).delete()
            db.collection("userList").document(sendUserId).collection("isentRequest").document(id).delete()
            
        }
    }
    // kabull bool
    func acceptBool () {
        let db = Firestore.firestore()
        let walkingDocData : [String:Any] = [
            "acceptDogWalkingBool" : false
        ]
        
        let uuid =  UUID().uuidString
        if let authUserId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(authUserId).collection("acceptDogWalking").document(uuid).setData(walkingDocData)
            
        }

    }
    
    // kabul edilen istek firebase
    func acceptToRequestToFirebase(getAdvert:Request){
        
        let db = Firestore.firestore()
        
        if let authUserId = Auth.auth().currentUser?.uid {
            
            if let sendId = getAdvert.sendId {
                if let advertId = getAdvert.advertId {
                    
                  
                        let docData : [String:Any] = [
                            "animalImage" : getAdvert.advertImage!,
                            "animalName" : getAdvert.advertAnimalName!,
                            "timeRange": getAdvert.advertRange!,
                            "sickBool" : getAdvert.advertAnimalSick!,
                            "ageAndGenus" : getAdvert.advertAnimalKindsandAge!,
                            "ownerNote" : getAdvert.ownerNote!,
                            "sickInfo":getAdvert.sickInfo!,
                            "userName" : getAdvert.userName!,
                            "userId" : getAdvert.userId!,
                            "situation" : "Aktifdeğil",
                            "date" : getAdvert.dateEvent!,
                            "sendRequestId" : getAdvert.sendId!,
                            "acceptAdvertUserName" : ""
                        ]
                        
                        
                        
                        db.collection("userList").document(authUserId).collection("comingAcceptAdvert").document(advertId).setData(docData)
                        db.collection("userList").document(sendId).collection("sendAcceptAdvert").document(advertId).setData(docData)
                        
                      
                        // Delete advert when accept button click
                        db.collection("userList").document(authUserId).collection("incomingRequest").document(advertId).delete()
                        db.collection("userList").document(sendId).collection("isentRequest").document(advertId).delete()
                        db.collection("dogWalkingAdvert").document(advertId).delete()
                        
                    
                    
                   
                        
                    
                    
                    
                    
                }
            }
            
            
            
            
            
            
        }
        
    }
    
    
    // kabul edilen istek firebase
    func getAcceptAdvert(collectionName:String,completion: @escaping (Request?)->()) {
        let db = Firestore.firestore()
        if let authUserId = Auth.auth().currentUser?.uid {
            let db = Firestore.firestore()
            if let authId = Auth.auth().currentUser?.uid {
                db.collection("userList").document(authId).collection(collectionName).getDocuments { snapshot, error in
                    if error != nil{
                        completion(nil)
                    }
                    else {
                        for document in (snapshot?.documents)! {
                            if let advertId = document.documentID as? String {
                                
                                if let animalName = document.get("animalName") as? String {
                                    if let animalKindsAge = document.get("ageAndGenus") as? String {
                                        if let hoursRange = document.get("timeRange") as? Int {
                                            
                                            if let sickInfo = document.get("sickInfo") as? String {
                                                
                                                if let animalImage = document.get("animalImage") as? String {
                                                    
                                                    if let ownerNote = document.get("ownerNote") as? String {
                                                        if let sickBool = document.get("sickBool") as? String {
                                                            if let userName = document.get("userName") as? String {
                                                                if let userId = document.get("userId") as? String {
                                                                    if let situation = document.get("situation") as? String {
                                                                        if let sendRequestId = document.get("sendRequestId") as? String {
                                                                            
                                                                            if let acceptAdvertUserName = document.get("acceptAdvertUserName") as? String {
                                                                                let a = (document.get("date") as? Timestamp)?.dateValue() ?? Date()
                                                                                let sendRequestAdvert = Request(advertId: advertId, advertImage: animalImage, advertRange: hoursRange, advertAnimalName: animalName, advertAnimalKindsandAge: animalKindsAge, advertAnimalSick: sickBool, ownerNote: ownerNote, sickInfo: sickInfo, userId: userId, userName: userName, dateEvent: a, situation: situation, sendId: sendRequestId,acceptUserName: acceptAdvertUserName)
                                                                            completion(sendRequestAdvert)
                                                                                
                                                                            }
                                                                            
                                                                           
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                            
                                                                        }
                                                                        
                                                                        
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                    
                                                                }
                                                            }
                                                            
                                                            
                                                        } } }}} }}}}}}
                
            }
            
        }
        
        
        
        
    }
    
    // tüm yorumları alma
    func getAllComment(completion: @escaping ([Comment]?)->()){
        
        let db = Firestore.firestore()
    
        if let userId = Auth.auth().currentUser?.uid {
            db.collection("userList").document(userId).collection("commet").getDocuments { snapshot, error in
                
                for documents in (snapshot?.documents)! {
                    if let commmentId = documents.documentID as? String {
                        if let comment = documents.get("comment") as? String {
                            if let userName = documents.get("userName") as? String {
                                if let score = documents.get("score") as? Int {
                                    
                                    let comment = Comment(comment: comment, score: score, userName: userName)
                                    self.commentList.append(comment)
                                    completion(self.commentList)
                                    
                                }
                            }
                        }
                    }
                }
                
            }
            
        }
       
        
        
    }
    
    
    
    func getSendNotiUserAccountInfo(userId:String,completion: @escaping ([Comment]?)->()){
        let db = Firestore.firestore()
        if let userId = userId  as? String {
            db.collection("userList").document(userId).collection("commet").getDocuments { snapshot, error in
                for documents in (snapshot?.documents)! {
                    if let comment = documents.get("comment") as? String {
                        if let score = documents.get("score") as? Int {
                            if let userName = documents.get("userName") as? String {
                           
                                let accountComment = Comment(comment: comment, score: score, userName: userName)
                                self.accountComments.append(accountComment)
                                completion(self.accountComments)
                            }
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
