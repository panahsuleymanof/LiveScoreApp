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
    var liveMatches: [(countryName: String, leagueName: String, liveMatch: LiveMatch)] = []
    var tappedCountry = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseFootballFile()
        extractLiveMatches()
        tableView.register(UINib(nibName: "\(LiveCell.self)", bundle: nil), forCellReuseIdentifier: "\(LiveCell.self)")
    }
    
    func extractLiveMatches() {
        for country in countries {
            for league in country.leagues {
                let matchData = (countryName: country.name, leagueName: league.name, liveMatch: league.liveMatch)
                liveMatches.append(matchData)
            }
        }
    }
    
    func parseFootballFile() {
        if let file = Bundle.main.url(forResource: "Football", withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                countries = try JSONDecoder().decode([Country].self, from: data)
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
        liveMatches.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LiveCell.self)", for: indexPath) as! LiveCell
        let matchData = liveMatches[indexPath.row]
        cell.configureCell(data: matchData.liveMatch)
        cell.configureCountryandLeague(country: matchData.countryName, league: matchData.leagueName)
        cell.navigationCallback = {
            let vc = self.storyboard?.instantiateViewController(identifier: "\(CountryController.self)") as! CountryController
            vc.title = matchData.countryName
            if let leagueIndex = self.countries.firstIndex(where: {$0.name == matchData.countryName}) {
                self.tappedCountry = self.countries[leagueIndex].leagues
            }
            vc.leagues = self.tappedCountry
            self.navigationController?.show(vc, sender: nil)
        }
        return cell
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}
