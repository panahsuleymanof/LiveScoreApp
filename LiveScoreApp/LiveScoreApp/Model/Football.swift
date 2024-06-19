//
//  Football.swift
//  LiveScoreApp
//
//  Created by Panah Suleymanli on 14.06.24.
//

import Foundation

struct Country: Codable {
    let name: String
    let leagues: [League]
}

struct League: Codable {
    let name: String
    let teams: [String]
    let liveMatch: LiveMatch
}

struct LiveMatch: Codable, LiveCellProtocol {

    
    let homeTeam: String
    let awayTeam: String
    let homeScore: String
    let awayScore: String
    
    // MARK: LiveCellProtocol
    var cellHomeName: String {
        homeTeam
    }
    
    var cellAwayName: String {
        awayTeam
    }
    
    var cellHomeScore: String {
        homeScore
    }
    
    var cellAwayScore: String {
        awayScore
    }
    

}
