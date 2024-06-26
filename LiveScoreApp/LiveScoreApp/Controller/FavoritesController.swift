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
        table.register(UINib(nibName: "\(LiveCell.self)", bundle: nil), forCellReuseIdentifier: "\(LiveCell.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager.getMatches { [weak self] match in
            self?.matches = match
            self?.table.reloadData() // Reload table view data
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "\(LiveCell.self)") as! LiveCell
        cell.configureFavoriteCell(ountry: matches[indexPath.row].countryName, league: matches[indexPath.row].leagueName, homeTeam: matches[indexPath.row].homeName, awayTeam: matches[indexPath.row].awayName, home: matches[indexPath.row].homeScore, away: matches[indexPath.row].awayScore)
        
//        cell.deleteCallBack = {
//            if let index = self.matches.firstIndex(where: {$0.homeName == self.matches[indexPath.row].homeName}) {
//                self.matches.remove(at: index)
//                self.table.reloadData()
//            }
//            self.manager.getMatches(complete: { matches in
//                if let index = matches.firstIndex(where: {$0.homeName == matches[indexPath.row].homeName}) {
//                    cell.makeNonRed()
//                    self.manager.deleteMatch(index: index)
//                }
//            }
//            )
//        }
//        
//        if let index = matches.firstIndex(where: {$0.homeName == matches[indexPath.row].homeName}) {
//            if matches[index].isfavorited {
//                cell.makeRed()
//            } else {
//                cell.makeNonRed()
//            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func configureMathes(data: [FavoriteMatches]) {
        matches.append(contentsOf: data)
    }
    
}
