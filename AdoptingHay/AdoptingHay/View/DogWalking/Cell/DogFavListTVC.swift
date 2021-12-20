//
//  DogFavListTVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 19.12.2021.
//

import UIKit

class DogFavListTVC: UITableViewCell {
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var kindAge: UILabel!
    
    @IBOutlet weak var sickBool: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
