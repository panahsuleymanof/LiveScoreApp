//
//  LiveCell.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 14.06.24.
//

import UIKit

protocol LiveCellProtocol {
    var cellHomeName: String { get }
    var cellAwayName: String { get }
    var cellHomeScore: String { get }
    var cellAwayScore: String { get }
}

class LiveCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var awayName: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var makeFavorite: UIButton!
    
    let manager = FavoriteFileManagerHelper()
    var navigationCallback: (() -> Void)?
    var addCallBack: (() -> Void)?
    var deleteCallBack: (() -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        countryName.addGestureRecognizer(tapGesture)
    }
    
    @objc func labelTapped() {
        navigationCallback?()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        countryName.isUserInteractionEnabled = true
    }
    
    @IBAction func favoritesTapped(_ sender: Any) {
        if makeFavorite.backgroundColor == UIColor.red {
            deleteCallBack?()
        } else {
            addCallBack?()
        }
    }
    
    func makeRed() {
        makeFavorite.backgroundColor = .red
    }
    
    func makeNonRed() {
        makeFavorite.backgroundColor = .none
    }
    
    func configureCell(data: LiveCellProtocol) {
        homeName.text = data.cellHomeName
        awayName.text = data.cellAwayName
        homeScore.text = data.cellHomeScore
        awayScore.text = data.cellAwayScore
    }
    
    func configureFavoriteCell(ountry: String, league: String, homeTeam: String, awayTeam: String, home: String, away: String) {
        homeName.text = homeTeam
        awayName.text = awayTeam
        homeScore.text = home
        awayScore.text = away
    }
    
    func configureCountryandLeague(country: String, league: String) {
        countryName.text = country
        leagueName.text = league
    }
}
