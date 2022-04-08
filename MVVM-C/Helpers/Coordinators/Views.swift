//
//  StoryBoards.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit

enum StoryBoards: String {
    case leagues = "Leagues"
    case teams = "Teams"
    case team = "Team"
}


enum StoryBoardVCIds: String {
    // leagues
    case leaguesVC = "LeaguesViewController"
    
    // teams
    case leagueView = "LeagueView"
    case teamsVC = "TeamsViewController"
    
    // team
    case teamVC = "TeamViewController"
}


enum StoryBoardCells: String {
    case leagueCell = "LeagueCell"
    case teamCell = "TeamCell"
}

extension UIStoryboard {
    class func instantiateInitialViewController(_ board: StoryBoards) -> UIViewController {
        let story = UIStoryboard(name: board.rawValue, bundle: nil)
        return story.instantiateInitialViewController()!
    }
    
    class func instantiate(_ storyboard: StoryBoards, _ vc: StoryBoardVCIds) -> UIViewController {
        let story = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return story.instantiateViewController(withIdentifier: vc.rawValue)
    }
}
