//
//  CountryController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 19.06.24.
//

import UIKit

class CountryController: UIViewController {
    
    var leagues = [League]()
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        table.register(UINib(nibName: "\(LeagueCell.self)", bundle: nil), forCellReuseIdentifier: "\(LeagueCell.self)")
    }
}

extension CountryController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LeagueCell.self)", for: indexPath) as! LeagueCell
        cell.configureLeague(name: "\(leagues[indexPath.row].name)", image: "flag")
        return cell
    }
}

extension CountryController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "\(TeamsController.self)") as! TeamsController
        vc.title = leagues[indexPath.row].name
        vc.teams = leagues[indexPath.row].teams
        navigationController?.show(vc, sender: nil)
    }
}
