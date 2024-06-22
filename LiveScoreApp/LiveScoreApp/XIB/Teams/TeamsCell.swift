//
//  TeamsCell.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 22.06.24.
//

import UIKit

class TeamsCell: UITableViewCell {

    @IBOutlet weak var placeNumber: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureTeam(number: String, image: String, name: String) {
        placeNumber.text = number
        teamName.text = name
        teamImage.image = UIImage(named: image)
    }
}
