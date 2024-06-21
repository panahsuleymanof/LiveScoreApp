//
//  LeagueCell.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 22.06.24.
//

import UIKit

class LeagueCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureLeague(name: String, image: String) {
        leagueImage.image = UIImage(named: image)
        leagueName.text = name
    }
    
}
