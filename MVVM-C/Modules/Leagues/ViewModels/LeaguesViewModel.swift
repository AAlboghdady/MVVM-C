//
//  LeaguesViewModel.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import RxSwift
import RxCocoa

class LeaguesViewModel: NSObject {
    
    weak var coordinator: AppCoordinator!
    private let disposeBag = DisposeBag()

    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var leaguesSubject = PublishSubject<[String]>()
    var leaguesObservable: Observable<[String]> {
        return leaguesSubject
    }
    
    private var errorMessageSubject = PublishSubject<String>()
    var errorMessageObservable: Observable<String> {
        return errorMessageSubject
    }
    
    func loadLeagues() {
        leaguesSubject.onNext(["Asdasd", "asdasdasd"])
    }
    
    func goToTeams() {
        coordinator.goToTeams()
    }
}
