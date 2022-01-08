//
//  NotiAccountVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 2.01.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import Kingfisher
class NotiAccountVC: UIViewController {
    var getUserId:String?
    private var accountCommentViewModelList : DogWalkingCommentViewModelList!
    let  myNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1220, height: 30))
    let myImageView:UIImageView = UIImageView()
    
    
    @IBOutlet weak var commentCount: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBOutlet weak var commentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAccountInfo()
        design()
        notiAccountOwner()
        
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        
    

    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAccountInfo()
        design()
        notiAccountOwner()
    }
    
    func getAccountInfo() {
        if let getUserId = getUserId {
            print(getUserId)
            DogWalkingService().getSendNotiUserAccountInfo(userId: getUserId) { comment in
                if let comment = comment {
                    self.accountCommentViewModelList = DogWalkingCommentViewModelList(commentList: comment)
                    self.commentCollectionView.reloadData()
                    let result = Double(self.accountCommentViewModelList.totalScore()) / Double(self.accountCommentViewModelList.commentListCount())
                    let totalScore:String = String(format: "%.1f", result)
                    self.scoreLabel.text = "Puan: \(totalScore)/5"
                    
                    
                    
                
                    
                }
            }
        }
     
    }
    
    
    func notiAccountOwner() {
        let db = Firestore.firestore()
        if let getUserId = getUserId {
            db.collection("userInfo").document(getUserId).getDocument { snapshot, error in
                if let userName = snapshot?.get("userName") as? String {
                    if let userImage = snapshot?.get("userImage") as? String {
                        
                        self.myNameLabel.text = userName
                        self.myImageView.kf.setImage(with: URL(string: userImage), placeholder: nil, options:[.transition(.fade(0.7))], completionHandler: nil)
//                        myImage.kf.setImage(with: URL(string:sendImage), placeholder: nil, options:[.transition(.fade(0.7))], completionHandler: nil)
                    }
                    
                    
                }
            }
        }
       
    }
    
    

  
    func design() {
        let myNewView=UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.height/4.5))
            myNewView.backgroundColor=UIColor.blue
               
        myNewView.layer.zPosition = -1
        self.view.addSubview(myNewView)
                

        // NameLabelDesign
     
             
        myNameLabel.textAlignment = .center
        myNameLabel.center.x = self.view.center.x
        myNameLabel.center.y = self.view.center.y/4.5
        myNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        myNameLabel.textColor = .white
        self.view.addSubview(myNameLabel)

        //AccountImage
                
                
         
                   
                    
                    myImageView.contentMode = UIView.ContentMode.scaleAspectFit
                    myImageView.frame.size.width = self.view.frame.width/4
                    myImageView.frame.size.height = self.view.frame.height/8
                    myImageView.center.x = self.view.center.x
                    myImageView.center.y = self.view.center.y/2.5
                    
                    myImageView.backgroundColor = .white
                    myImageView.layer.borderColor = UIColor.blue.cgColor
                    myImageView.layer.borderWidth = 3
                    myImageView.layer.cornerRadius = 10
                    view.addSubview(myImageView)
                    
                
                
                
                
             
    }
    

 

}


extension NotiAccountVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.commentCount.text = "Sayısı : \(self.accountCommentViewModelList == nil ? 0 : self.accountCommentViewModelList.commentListCount())"
        return self.accountCommentViewModelList == nil ? 0 : self.accountCommentViewModelList.commentListCount()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = commentCollectionView.dequeueReusableCell(withReuseIdentifier: "cellAccountComment", for: indexPath) as! CommentAccountCVC
        
        let comment = self.accountCommentViewModelList.commentAtIndex(indexPath.row)
        
        cell.makeComent.text = comment.comment
        cell.makeScore.text = "Puan \(String(comment.score))"
        cell.makeUserName.text = comment.userName
        
        cell.layer.cornerRadius = 25
        cell.layer.borderColor =  UIColor.blue.cgColor
        cell.layer.borderWidth = 2
        
        return cell
    }
    
    
}














