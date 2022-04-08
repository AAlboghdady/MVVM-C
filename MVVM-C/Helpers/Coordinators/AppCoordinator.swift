//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // launch leagues view controller
        goToLeagues()
    }
    
    func goToLeagues() {
        // Instantiate Logi
        let leaguesVC = UIStoryboard.instantiate(.leagues, .leaguesVC) as! LeaguesViewController
        // Instantiate LoginViewModel
        let leaguesViewModel = LeaguesViewModel.init()
        // Set the Coordinator to the ViewModel
        leaguesViewModel.coordinator = self
        // Set the ViewModel to ViewController
        leaguesVC.viewModel = leaguesViewModel
        // Push it.
        navigationController.pushViewController(leaguesVC, animated: true)
    }
    
    func goToTeams(id: Int) {
        // Instantiate Logi
        let leaguesVC = UIStoryboard.instantiate(.leagues, .leaguesVC) as! TeamsViewController
        // Instantiate LoginViewModel
        let leaguesViewModel = LeaguesViewModel.init()
        // Set the Coordinator to the ViewModel
        leaguesViewModel.coordinator = self
        // Set the ViewModel to ViewController
//        leaguesVC.viewModel = leaguesViewModel
        // Push it.
        navigationController.pushViewController(leaguesVC, animated: true)
    }
    
    func goToTeam() {
        // Instantiate Logi
        let leaguesVC = UIStoryboard.instantiate(.leagues, .leaguesVC) as! TeamsViewController
        // Instantiate LoginViewModel
        let leaguesViewModel = LeaguesViewModel.init()
        // Set the Coordinator to the ViewModel
        leaguesViewModel.coordinator = self
        // Set the ViewModel to ViewController
//        leaguesVC.viewModel = leaguesViewModel
        // Push it.
        navigationController.pushViewController(leaguesVC, animated: true)
    }
}
