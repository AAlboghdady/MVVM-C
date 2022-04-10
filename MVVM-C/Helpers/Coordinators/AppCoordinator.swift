//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    static let shared = AppCoordinator(navigationController: UINavigationController())
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // launch leagues view controller
        goToLeagues()
    }
    
    func goToLeagues() {
        // Instantiate LeaguesViewController
        let leaguesVC = UIStoryboard.instantiate(.leagues, .leagues) as! LeaguesViewController
        // Instantiate ViewModel
        let leaguesViewModel = LeaguesViewModel.init()
        // Set the ViewModel to ViewController
        leaguesVC.viewModel = leaguesViewModel
        // Push it.
        navigationController.pushViewController(leaguesVC, animated: true)
        Constants.uWindow?.rootViewController = navigationController
        Constants.uWindow?.makeKeyAndVisible()
    }
    
    func goToTeams(league: Competition) {
        // Instantiate TeamsViewController
        let teamsVC = UIStoryboard.instantiate(.teams, .teams) as! TeamsViewController
        teamsVC.league = league
        // Instantiate ViewModel
        let teamsViewModel = TeamsViewModel.init()
        // Set the id to the ViewController
        teamsViewModel.competitionId = league.id!
        // Set the ViewModel to ViewController
        teamsVC.viewModel = teamsViewModel
        // Push it.
        navigationController.pushViewController(teamsVC, animated: true)
    }
    
    func goToTeam(id: Int) {
        // Instantiate TeamsViewController
        let teamVC = UIStoryboard.instantiate(.team, .team) as! TeamViewController
        // Instantiate ViewModel
        let teamViewModel = LeaguesViewModel.init()
        // Set the id to the ViewController
//        teamsViewModel.competitionId = id
        // Set the ViewModel to ViewController
//        leaguesVC.viewModel = leaguesViewModel
        // Push it.
        navigationController.pushViewController(teamVC, animated: true)
    }
}
