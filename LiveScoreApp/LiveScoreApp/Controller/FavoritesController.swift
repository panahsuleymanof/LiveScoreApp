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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "\(LiveCell.self)", bundle: nil), forCellReuseIdentifier: "\(LiveCell.self)")
    }
    
    func configureMathes(data: [FavoriteMatches]) {
        matches.append(contentsOf: data)
        print(matches)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(LiveCell.self)") as! LiveCell
        cell.configureCountryandLeague(country: matches[indexPath.row].countryName, league: matches[indexPath.row].leagueName)
        return cell
    }
    

}
