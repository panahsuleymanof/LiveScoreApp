//
//  HomeController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 08.06.24.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseFootballFile()
        tableView.register(UINib(nibName: "\(LiveCell.self)", bundle: nil), forCellReuseIdentifier: "\(LiveCell.self)")
    }
    
    func parseFootballFile() {
        if let file = Bundle.main.url(forResource: "Football", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                countries = try JSONDecoder().decode([Country].self, from: data)
                print("football: \(countries)")
            } catch {
                showError(message: error.localizedDescription)
            }
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error",
                                      message: message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LiveCell.self)", for: indexPath) as! LiveCell
        cell.configureCell(data: countries[indexPath.row].leagues[0].liveMatch)
        return cell
    }
    
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
