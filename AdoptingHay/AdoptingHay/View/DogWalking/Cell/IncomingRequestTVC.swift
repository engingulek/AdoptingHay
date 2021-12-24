//
//  IncomingRequestTVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 24.12.2021.
//

import UIKit

class IncomingRequestTVC: UITableViewCell {
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var range: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var sickBool: UILabel!
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
