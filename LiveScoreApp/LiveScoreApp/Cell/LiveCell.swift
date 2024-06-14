//
//  LiveCell.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 14.06.24.
//

import UIKit

class LiveCell: UITableViewCell {

    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favoritesTapped(_ sender: Any) {
    }
}
