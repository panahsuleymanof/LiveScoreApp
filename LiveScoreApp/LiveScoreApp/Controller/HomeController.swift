//
//  HomeController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 08.06.24.
//

import UIKit

class HomeController: UIViewController {
    
    
    @IBOutlet weak var table: UITableView!
    var countries = [Country]()
    var liveMatches: [(countryName: String, leagueName: String, liveMatch: LiveMatch)] = []
    var tappedCountry = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseFootballFile()
        extractLiveMatches()
        table.register(UINib(nibName: "\(LiveCell.self)", bundle: nil), forCellReuseIdentifier: "\(LiveCell.self)")
        self.table.tableHeaderView = self.headerView()
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

extension UIColor {
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
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
    
    private func headerView() -> UIView {
         let view = UIView(frame: CGRect(x: 0,
                                         y: 0,
                                         width: self.table.frame.width,
                                         height: 120))
        view.backgroundColor = UIColor(hex: "#010A0F")
        
        let textfield = UITextField()
        
        return view
    }
}

extension HomeController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
}
