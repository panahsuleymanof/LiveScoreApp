//
//  HomeController.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 08.06.24.
//

import UIKit

// MARK: - HomeController Class

class HomeController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var countries = [Country]()
    var liveMatches: [(countryName: String, leagueName: String, liveMatch: LiveMatch)] = []
    var favoritedMatches = [FavoriteMatches]()
    var tappedCountry = [League]()
    var filteredMatches: [(countryName: String, leagueName: String, liveMatch: LiveMatch)] = []
    var manager = FavoriteFileManagerHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        parseFootballFile()
        extractLiveMatches()
        table.register(UINib(nibName: "\(LiveCell.self)", bundle: nil), forCellReuseIdentifier: "\(LiveCell.self)")
        self.table.tableHeaderView = self.headerView()
        table.dataSource = self
        table.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        manager.getMatches { [weak self] match in
            self?.favoritedMatches = match
            self?.table.reloadData()
        }
    }
    
    func extractLiveMatches() {
        for country in countries {
            for league in country.leagues {
                let matchData = (countryName: country.name, leagueName: league.name, liveMatch: league.liveMatch)
                liveMatches.append(matchData)
            }
        }
        filteredMatches = liveMatches
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
    
    private func headerView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.table.frame.width, height: 100))
        headerView.backgroundColor = UIColor(hex: "00141e")
        
        let innerView = UIView()
        innerView.backgroundColor = UIColor(red: 0.0, green: 20.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        innerView.layer.cornerRadius = 10
        innerView.translatesAutoresizingMaskIntoConstraints = false
        
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Search for clubs, countries or leagues",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 0.7, alpha: 1.0)]
        )
        textField.textColor = UIColor(white: 0.9, alpha: 1.0)
        textField.borderStyle = .roundedRect
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = UIColor(red: 28.0/255.0, green: 43.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        innerView.addSubview(textField)
        
        headerView.addSubview(innerView)
        
        NSLayoutConstraint.activate([
            innerView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            innerView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            innerView.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.9),
            innerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: innerView.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: innerView.trailingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: innerView.topAnchor, constant: 5),
            textField.bottomAnchor.constraint(equalTo: innerView.bottomAnchor, constant: -5)
        ])
        
        return headerView
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text, !searchText.isEmpty else {
            filteredMatches = liveMatches
            table.reloadData()
            return
        }
        
        filteredMatches = liveMatches.filter { match in
            match.countryName.lowercased().contains(searchText.lowercased()) ||
            match.leagueName.lowercased().contains(searchText.lowercased()) ||
            match.liveMatch.homeTeam.lowercased().contains(searchText.lowercased()) ||
            match.liveMatch.awayTeam.lowercased().contains(searchText.lowercased())
        }
        
        table.reloadData()
    }
}

extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         filteredMatches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LiveCell.self)", for: indexPath) as! LiveCell
        let matchData = filteredMatches[indexPath.row]
        cell.configureCell(data: matchData.liveMatch)
        cell.configureCountryandLeague(country: matchData.countryName, league: matchData.leagueName)
        
        cell.makeNonRed()
        
        if let index = favoritedMatches.firstIndex(where: { $0.homeName == matchData.liveMatch.homeTeam }) {
            if favoritedMatches[index].isfavorited {
                cell.makeRed()
            }
        }
        
        cell.addCallBack = {
            self.manager.getMatches(complete: { matches  in
                let newMatch = (FavoriteMatches(countryName: matchData.countryName, leagueName: matchData.leagueName, homeName: matchData.liveMatch.homeTeam, awayName: matchData.liveMatch.awayTeam, homeScore: matchData.liveMatch.homeScore, awayScore: matchData.liveMatch.awayScore, isfavorited: true))
                self.favoritedMatches.append(newMatch)
                self.manager.saveMatch(data: self.favoritedMatches)
                cell.makeRed()
            })
        }
        
        cell.deleteCallBack = {
            if let index = self.favoritedMatches.firstIndex(where: {$0.homeName == matchData.liveMatch.homeTeam}) {
                self.favoritedMatches.remove(at: index)
            }
            self.manager.getMatches(complete: { matches in
                if let index = matches.firstIndex(where: {$0.homeName == matchData.liveMatch.homeTeam}) {
                    self.manager.deleteMatch(index: index)
                    cell.makeNonRed()
                    self.table.reloadData()
                }
            })
        }
        
        return cell
    }
}

extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedMatch = filteredMatches[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "\(CountryController.self)") as! CountryController
        vc.title = selectedMatch.countryName
        if let leagueIndex = self.countries.firstIndex(where: { $0.name == selectedMatch.countryName }) {
            self.tappedCountry = self.countries[leagueIndex].leagues
        }
        vc.leagues = self.tappedCountry
        self.navigationController?.show(vc, sender: nil)
    }
}

// MARK: - UIColor Extension

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
