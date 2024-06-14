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
    let live_match: LiveMatch
}

struct LiveMatch: Codable {
    let home_team: String
    let away_team: String
    let home_score: String
    let away_score: String
}
