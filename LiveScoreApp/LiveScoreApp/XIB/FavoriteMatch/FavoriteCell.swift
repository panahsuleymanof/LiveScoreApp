//
//  FavoriteCell.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 28.06.24.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var awayTeamScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    func configureFavoriteCell(homeTeam: String, awayTeam: String, home: String, away: String) {
        homeTeamName.text = homeTeam
        awayTeamName.text = awayTeam
        homeTeamScore.text = home
        awayTeamScore.text = away
    }
    
    func configureCountryandLeague(country: String, league: String) {
        countryName.text = country
        leagueName.text = league
    }
    
}
