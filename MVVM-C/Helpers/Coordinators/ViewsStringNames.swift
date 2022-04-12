//
//  StoryBoards.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import Foundation

enum StoryBoards: String {
    case leagues = "Leagues"
    case teams = "Teams"
    case team = "Team"
}


enum StoryBoardVCIds: String {
    // leagues
    case leagues = "LeaguesViewController"
    case leagueView = "LeagueView"
    
    // teams
    case teams = "TeamsViewController"
    case teamView = "TeamView"
    
    // team
    case team = "TeamViewController"
    case matchView = "MatchView"
}


enum StoryBoardCells: String {
    case leagueCell = "LeagueCell"
    case teamCell = "TeamCell"
    case matchCell = "MatchCell"
}
