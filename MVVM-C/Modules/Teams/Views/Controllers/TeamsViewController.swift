//
//  TeamsViewController.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class TeamsViewController: UIViewController {

    @IBOutlet weak var leagueView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TeamsViewModel!
    let disposeBag = DisposeBag()
    
    var league: Competition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        subscribeToLoading()
        subscribeToErrorMessage()
        
        subscribeToTeams()
        
        viewModel.getAllTeamsFromDataBase()
    }
    
    func setupViews() {
        title = league.name
        addLeagueView(league: league)
        
        tableView.register(UINib(nibName: StoryBoardCells.teamCell.rawValue, bundle: nil), forCellReuseIdentifier: StoryBoardCells.teamCell.rawValue)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func addLeagueView(league: Competition) {
        let controller = UIStoryboard.instantiate(.leagues, .leagueView) as! LeagueView
        controller.view.frame = CGRect(x: 8, y: 8, width: leagueView.frame.size.width - 16, height: leagueView.frame.size.height - 16)
        controller.setupViews(name: league.name ?? "", image: "")
        leagueView.addSubview(controller.view)
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
    
    func subscribeToTeams() {
        // tableView cells
        viewModel.teamsObservable
            .bind(to: tableView.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardCells.teamCell.rawValue, for: IndexPath(row: row, section: 0)) as! TeamCell
                cell.configure(team: item)
                return cell
            }
            .disposed(by: disposeBag)
        // tableview model selected
        tableView.rx.modelSelected(Team.self)
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.viewModel.goToTeam(team: item)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension TeamsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
