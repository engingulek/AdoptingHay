//
//  CommetPageVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.01.2022.
//

import UIKit

class CommetPageVC: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var commentCount: UILabel!
  private var commentViewModelList : DogWalkingCommentViewModelList!

    @IBOutlet weak var commetCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commetCollectionView.delegate = self
        commetCollectionView.dataSource = self
        getCommnet()
       

     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getCommnet()
    }
    
    
    func getCommnet() {
        DogWalkingService().getAllComment { comment in
            if let comment = comment {
                self.commentViewModelList = DogWalkingCommentViewModelList(commentList: comment)
                self.commetCollectionView.reloadData()
              
                let result = Double(self.commentViewModelList.totalScore()) / Double(self.commentViewModelList.commentListCount())
                let totalScore:String = String(format: "%.1f", result)
                self.scoreLabel.text = "Puan: \(totalScore)/5"
               
            }
        }
    }
    


}





extension CommetPageVC : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        self.commentCount.text = "Sayısı : \(self.commentViewModelList == nil ? 0 : self.commentViewModelList.commentListCount())"
        return self.commentViewModelList == nil ? 0 : self.commentViewModelList.commentListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.commetCollectionView.dequeueReusableCell(withReuseIdentifier: "cellComment", for: indexPath) as! CommetCVC
        
        let comment = self.commentViewModelList.commentAtIndex(indexPath.row)
        
        cell.comment.text = comment.comment
        cell.score.text = "Puan \(String(comment.score))"
        cell.userName.text = comment.userName
  
        cell.layer.cornerRadius = 25
        cell.layer.borderColor =  UIColor.purple.cgColor
        cell.layer.borderWidth = 2
        
    
     
        return cell
        
    }
    
  
    
    
}
