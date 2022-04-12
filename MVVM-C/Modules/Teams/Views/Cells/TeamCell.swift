//
//  TeamCell.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 09/04/2022.
//

import UIKit

class TeamCell: UITableViewCell {
    
    private var team: Team?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(team: Team) {
        self.team = team
        addTeamView(team: team)
    }
    
    func addTeamView(team: Team) {
        // loading the TeamView inside the cell
        let controller = UIStoryboard.instantiate(.teams, .teamView) as! TeamView
        controller.view.frame = CGRect(x: 8, y: 8, width: contentView.frame.size.width - 16, height: contentView.frame.size.height - 16)
        controller.setupViews(name: team.name ?? "", image: team.crestUrl ?? "")
        contentView.addSubview(controller.view)
    }
}
