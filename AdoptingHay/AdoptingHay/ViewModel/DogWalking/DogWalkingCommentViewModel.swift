//
//  DogWalkingCommentViewModel.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.01.2022.
//

import Foundation


struct DogWalkingCommentViewModelList {
    var commentList : [Comment]

    func commentListCount()->Int {
        return commentList.count
    }
    
    func commentAtIndex(_ index:Int) -> CommentViewModel {
        let comment = commentList[index]
        
        return CommentViewModel(commentMake: comment)

    }
    
    func totalScore() -> Int {
        var a = 0
        for i in 0...self.commentListCount()-1 {
          
            a = a + self.commentAtIndex(i).score
            
        }
        
        return a
    }
   
}


struct CommentViewModel {
    let commentMake:Comment
    var comment: String {
        return self.commentMake.comment!

    }
    
    var score:Int {
        return self.commentMake.score!
    }
    
    var userName: String {
        return self.commentMake.userName!
    }
    
   
}



