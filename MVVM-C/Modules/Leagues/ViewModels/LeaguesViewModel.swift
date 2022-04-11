//
//  LeaguesViewModel.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import RxSwift
import RxCocoa
import GRDB

class LeaguesViewModel: NSObject {
    
    private let disposeBag = DisposeBag()
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var leaguesSubject = PublishSubject<[Competition]>()
    var leaguesObservable: Observable<[Competition]> {
        return leaguesSubject
    }
    
    private var errorMessageSubject = PublishSubject<String>()
    var errorMessageObservable: Observable<String> {
        return errorMessageSubject
    }
    
    func loadLeagues() {
        loadingBehavior.accept(true)
        NetworkRequest.shared.sendRequest(function: .competitions, model: CompetitionsResponse.self) { [weak self] response in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            guard let competitions = response.competitions else {
                print(response.message ?? "")
                self.errorMessageSubject.onNext(response.message ?? "")
                return
            }
            self.leaguesSubject.onNext(competitions)
            self.saveLeagues(leagues: competitions)
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            print(error)
            self.errorMessageSubject.onNext(error)
        }
    }
    
    func saveLeagues(leagues: [Competition]) {
        DispatchQueue.global(qos: .background).async {
            for i in 0..<leagues.count {
                var league = leagues[i]
                try! AppDatabase.shared.saveLeague(&league)
            }
        }
    }
    
    func getAllLeaguesFromDataBase() {
        // check if the leagues are stored in the database first
        let request: QueryInterfaceRequest<Competition> = Competition.all()
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
                    self?.loadLeagues()
                },
                onChange: { [weak self] leagues in
                    guard let self = self, !leagues.isEmpty else {
                        // the data is empty
                        // load data from api
                        self?.loadLeagues()
                        return
                    }
                    self.leaguesSubject.onNext(leagues)
                })
    }
    
    func goToTeams(league: Competition) {
        AppCoordinator.shared.goToTeams(league: league)
    }
    
    func dispose() {
        
    }
}
