//
//  LeaguesViewController.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class LeaguesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: LeaguesViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        subscribeToLoading()
        subscribeToErrorMessage()
        
        subscribeToLaegues()
        
        viewModel.loadLeagues()
    }
    
    func setupViews() {
        title = "Leagues"
        
        tableView.register(UINib(nibName: StoryBoardCells.leagueCell.rawValue, bundle: nil), forCellReuseIdentifier: StoryBoardCells.leagueCell.rawValue)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func subscribeToLoading() {
        viewModel.loadingBehavior.subscribe { (isLoading) in
//            self.showLoading(isLoading)
        }.disposed(by: disposeBag)
    }
    
    func subscribeToErrorMessage() {
        viewModel.errorMessageObservable.subscribe { (error) in
//            self.showAlertError(subTitle: error)
        }.disposed(by: disposeBag)
    }
    
    func subscribeToLaegues() {
        // tableView
        viewModel.leaguesObservable
            .bind(to: tableView
                .rx
                .items(cellIdentifier: StoryBoardCells.leagueCell.rawValue,
                       cellType: LeagueCell.self)) { _, item, cell in
                cell.configure(league: item)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.viewModel.goToTeams()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension LeaguesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
