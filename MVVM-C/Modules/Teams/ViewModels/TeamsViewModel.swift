//
//  TeamsViewModel.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 09/04/2022.
//

import RxSwift
import RxCocoa
import GRDB

class TeamsViewModel: NSObject {
    
    private let disposeBag = DisposeBag()
    var competitionId: Int64 = 0
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var teamsSubject = PublishSubject<[Team]>()
    var teamsObservable: Observable<[Team]> {
        return teamsSubject
    }
    
    private var errorMessageSubject = PublishSubject<String>()
    var errorMessageObservable: Observable<String> {
        return errorMessageSubject
    }
    
    func loadTeams() {
        loadingBehavior.accept(true)
        NetworkRequest.shared.sendRequest(function: .teams(competitionId: competitionId), model: TeamsResponse.self) { [weak self] response in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            guard let teams = response.teams else {
                print(response.message ?? "")
                self.errorMessageSubject.onNext(response.message ?? "")
                return
            }
            self.teamsSubject.onNext(teams)
            self.saveTeams(teams: teams)
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            print(error)
            self.errorMessageSubject.onNext(error)
        }
    }
    
    func saveTeams(teams: [Team]) {
        // saving teams to the database
        DispatchQueue.global(qos: .background).async {
            for i in 0..<teams.count {
                var team = teams[i]
                team.competitionId = self.competitionId
                try! AppDatabase.shared.saveTeam(&team)
            }
        }
    }
    
    func getAllTeamsFromDataBase() {
        // check if the teams are stored in the database first
        let request: QueryInterfaceRequest<Team> = Team.filter(competitionId: competitionId)
        _ = ValueObservation
            .tracking(request.fetchAll(_:))
            .start(
                in: AppDatabase.shared.databaseReader,
                // Immediate scheduling feeds the data source right on subscription,
                // and avoids an undesired animation when the application starts.
                scheduling: .immediate,
                onError: { [weak self] error in
                    // no data found
                    // load data from api
                    self?.loadTeams()
                },
                onChange: { [weak self] teams in
                    guard let self = self, !teams.isEmpty else {
                        // the data is empty
                        // load data from api
                        self?.loadTeams()
                        return
                    }
                    self.teamsSubject.onNext(teams)
                })
    }
    
    func goToTeam(team: Team) {
        AppCoordinator.shared.goToTeam(team: team)
    }
}

