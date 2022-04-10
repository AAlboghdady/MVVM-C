//
//  TeamsViewModel.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 09/04/2022.
//

import RxSwift
import RxCocoa
import Moya

class TeamsViewModel: NSObject {
    
    private let disposeBag = DisposeBag()
    var competitionId = 0
    
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
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            print(error)
            self.errorMessageSubject.onNext(error)
        }
    }
    
    func goToTeam(id: Int) {
        AppCoordinator.shared.goToTeam(id: competitionId)
    }
}

