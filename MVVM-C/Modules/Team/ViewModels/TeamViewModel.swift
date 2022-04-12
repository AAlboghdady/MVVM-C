//
//  TeamViewModel.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 10/04/2022.
//

import RxSwift
import RxCocoa

class TeamViewModel: NSObject {
    
    private let disposeBag = DisposeBag()
    var teamId: Int64 = 0
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var matchesSubject = PublishSubject<[Match]>()
    var matchesObservable: Observable<[Match]> {
        return matchesSubject
    }
    
    private var errorMessageSubject = PublishSubject<String>()
    var errorMessageObservable: Observable<String> {
        return errorMessageSubject
    }
    
    func loadMathces() {
        loadingBehavior.accept(true)
        NetworkRequest.shared.sendRequest(function: .matches(teamId: teamId), model: TeamResponse.self) { [weak self] response in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            guard let teams = response.matches else {
                print(response.message ?? "")
                self.errorMessageSubject.onNext(response.message ?? "")
                return
            }
            self.matchesSubject.onNext(teams)
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.loadingBehavior.accept(false)
            print(error)
            self.errorMessageSubject.onNext(error)
        }
    }
}
