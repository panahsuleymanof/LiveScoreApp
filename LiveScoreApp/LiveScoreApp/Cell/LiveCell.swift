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
    
    func configureCell(data: LiveCellProtocol) {
        homeName.text = data.cellHomeName
        awayName.text = data.cellAwayName
        homeScore.text = data.cellHomeScore
        awayScore.text = data.cellAwayScore
    }
}
