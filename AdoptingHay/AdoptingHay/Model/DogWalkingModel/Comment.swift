//
//  Comment.swift
//  AdoptingHay
//
//  Created by engin gülek on 1.01.2022.
//

import Foundation

class Comment {
    var comment : String?
    var score : Int?
    var userName : String?

    
    init(comment:String,score:Int,userName:String) {
        self.comment = comment;
        self.score = score
        self.userName = userName

     
    
    }
}
