//
//  LeaguesViewModel.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import Foundation

class LeaguesViewModel {
    
    weak var coordinator: AppCoordinator!
    
    func goToTeams() {
        coordinator.goToTeams()
    }
}
