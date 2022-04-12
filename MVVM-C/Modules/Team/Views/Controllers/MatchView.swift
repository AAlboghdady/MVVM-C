//
//  MatchView.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 10/04/2022.
//

import UIKit
import Nuke

class MatchView: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var scheduledDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setupViews(match: Match) {
        dateLabel.text = "\(match.utcDate?.split(separator: "T").first ?? "")"
        if match.status == "SCHEDULED" {
            // if the match is SCHEDULED hide result
            statusLabel.text = match.status
            scheduledDateLabel.text = "\(match.utcDate?.split(separator: "T").first ?? "")"
            
            resultLabel.isHidden = true
        } else {
            // if the match is not SCHEDULED hide status and scheduled date
            let homeTeamScore = "\(match.score?.fullTime?.homeTeam ?? 0)"
            let awayTeamScore = "\(match.score?.fullTime?.awayTeam ?? 0)"
            resultLabel.text = homeTeamScore + awayTeamScore
            
            statusLabel.isHidden = true
            scheduledDateLabel.isHidden = true
        }
        // HINT: - no images found in the matches for the home and the away teams api service
        // so i commented the loading code
//        if let url = URL(string: match.homeTeam?.name ?? "") {
//            Nuke.loadImage(with: url, into: homeTeamImageView)
//        }
//        if let url = URL(string: match.awayTeam?.name ?? "") {
//            Nuke.loadImage(with: url, into: awayTeamImageView)
//        }
    }
}
