//
//  DogMyAdvertCell.swift
//  AdoptingHay
//
//  Created by engin gülek on 20.12.2021.
//

import UIKit

class DogMyAdvertCell: UITableViewCell {

    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var rangeLabel: UILabel!
    
    @IBOutlet weak var genusAge: UILabel!
    
    @IBOutlet weak var sickBool: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
