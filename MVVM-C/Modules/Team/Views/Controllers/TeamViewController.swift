//
//  TeamViewController.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class TeamViewController: UIViewController {
    
    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TeamViewModel!
    let disposeBag = DisposeBag()
    
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        subscribeToLoading()
        subscribeToErrorMessage()
        
        subscribeToTeams()
        
        viewModel.loadMathces()
    }
    
    func setupViews() {
        title = team.name
        addTeamView(team: team)
        
        tableView.register(UINib(nibName: StoryBoardCells.matchCell.rawValue, bundle: nil), forCellReuseIdentifier: StoryBoardCells.matchCell.rawValue)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func addTeamView(team: Team) {
        let controller = UIStoryboard.instantiate(.teams, .teamView) as! TeamView
        controller.view.frame = CGRect(x: 8, y: 8, width: teamView.frame.size.width - 16, height: teamView.frame.size.height - 16)
        controller.setupViews(name: team.name ?? "", image: "")
        teamView.addSubview(controller.view)
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
        viewModel.matchesObservable
            .bind(to: tableView.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardCells.matchCell.rawValue, for: IndexPath(row: row, section: 0)) as! MatchCell
                cell.configure(match: item)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
