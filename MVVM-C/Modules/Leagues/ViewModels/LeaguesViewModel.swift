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
    
    weak var coordinator: AppCoordinator!
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
        Network.sendRequest(function: .competitions, model: CompetitionsResponse.self) { [weak self] response in
            guard let self = self,
            let competitions = response.competitions else { return }
            self.leaguesSubject.onNext(competitions)
        } failure: { [weak self] error in
            guard let self = self else { return }
            print(error)
            self.errorMessageSubject.onNext(error)
        }
    }
    
    func goToTeams(id: Int) {
        coordinator.goToTeams(id: id)
    }
}
