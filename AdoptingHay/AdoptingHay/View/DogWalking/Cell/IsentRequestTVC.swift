//
//  IsentRequest.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.12.2021.
//

import UIKit

class IsentRequestTVC: UITableViewCell {
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var range: UILabel!
    
    @IBOutlet weak var sick: UILabel!
    @IBOutlet weak var genusAge: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
