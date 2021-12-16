//
//  FavoriListTVC.swift
//  AdoptingHay
//
//  Created by engin gülek on 17.12.2021.
//

import UIKit

class FavoriListTVC: UITableViewCell {

    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var animalName: UILabel!
    
    @IBOutlet weak var animalKinds: UILabel!
    
    @IBOutlet weak var animalSick: UILabel!
    @IBOutlet weak var animalAge: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
