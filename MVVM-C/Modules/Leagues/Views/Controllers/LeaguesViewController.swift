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
        
        subscribeToLeagues()
        
        viewModel.getAllLeaguesFromDataBase()
    }
    
    func setupViews() {
        title = "Leagues"
        
        tableView.register(UINib(nibName: StoryBoardCells.leagueCell.rawValue, bundle: nil), forCellReuseIdentifier: StoryBoardCells.leagueCell.rawValue)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func subscribeToLoading() {
        viewModel.loadingBehavior.subscribe { (isLoading) in
            self.showLoading(isLoading)
        }.disposed(by: disposeBag)
    }
    
    func subscribeToErrorMessage() {
        viewModel.errorMessageObservable.subscribe { (error) in
            self.showErrorAlert(title: error)
        }.disposed(by: disposeBag)
    }
    
    func subscribeToLeagues() {
        // tableView cells
        viewModel.leaguesObservable
            .bind(to: tableView.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardCells.leagueCell.rawValue, for: IndexPath(row: row, section: 0)) as! LeagueCell
                cell.configure(league: item)
                return cell
            }
            .disposed(by: disposeBag)
        // tableview model selected
        tableView.rx.modelSelected(Competition.self)
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.viewModel.goToTeams(league: item)
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
