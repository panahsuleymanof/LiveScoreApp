//
//  FavoritesController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 14.06.24.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var table: UITableView!
    
    var matches = [FavoriteMatches]()
    let manager = FavoriteFileManagerHelper()
    var filteredMatches: [(countryName: String, leagueName: String, liveMatch: LiveMatch)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        table.register(UINib(nibName: "\(FavoriteCell.self)", bundle: nil), forCellReuseIdentifier: "\(FavoriteCell.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager.getMatches { [weak self] match in
            self?.matches = match
            self?.table.reloadData()
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(FavoriteCell.self)") as! FavoriteCell
        cell.configureFavoriteCell( homeTeam: matches[indexPath.row].homeName, awayTeam: matches[indexPath.row].awayName, home: matches[indexPath.row].homeScore, away: matches[indexPath.row].awayScore)
        cell.configureCountryandLeague(country: matches[indexPath.row].countryName, league: matches[indexPath.row].leagueName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func configureMathes(data: [FavoriteMatches]) {
        matches.append(contentsOf: data)
    }
    
}
