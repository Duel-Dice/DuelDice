//
//  RankCell.swift
//  DuelDice
//
//  Created by Euimin Chung on 2021/12/31.
//

import UIKit

class RankCell: UITableViewCell {

    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var userIdView: UIView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var diceAmountView: UIView!
    @IBOutlet weak var diceAmountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
