//
//  TeamsController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 22.06.24.
//

import UIKit

class TeamsController: UIViewController {

    var teams: [String] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "\(TeamsCell.self)", bundle: nil), forCellReuseIdentifier: "\(TeamsCell.self)")
    }
}

extension TeamsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TeamsCell.self)", for: indexPath) as! TeamsCell
        cell.configureTeam(number: "\(indexPath.row+1).", image: "soccer", name: "\(teams[indexPath.row])")
        return cell
    }
}

extension TeamsController: UITableViewDelegate {
    
}
