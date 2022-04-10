//
//  LeaguesViewModel.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import RxSwift
import RxCocoa
import Moya

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
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            print(error)
            self.errorMessageSubject.onNext(error)
        }
    }
    
    func goToTeams(league: Competition) {
        AppCoordinator.shared.goToTeams(league: league)
    }
    
    func dispose() {
        
    }
}
