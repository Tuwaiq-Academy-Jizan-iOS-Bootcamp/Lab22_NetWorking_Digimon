//
//  DigemonTableViewCell.swift
//  workAPI
//
//  Created by NoON .. on 21/04/1443 AH.
//

import UIKit

class DigemonTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var nameCellLabel: UILabel!
    @IBOutlet weak var levelCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
