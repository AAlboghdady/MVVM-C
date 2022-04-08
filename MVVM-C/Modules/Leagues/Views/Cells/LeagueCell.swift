//
//  LeagueCell.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit

class LeagueCell: UITableViewCell {
    
    private var league: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(league: String) {
        self.league = league
        addLeagueView(league: league)
    }
    
    func addLeagueView(league: String) {
        let controller = UIStoryboard.instantiate(.leagues, .leagueView) as! LeagueView
        controller.view.frame = CGRect(x: 8, y: 8, width: contentView.frame.size.width - 16, height: contentView.frame.size.height - 16)
        controller.setupViews(name: league, image: "")
        contentView.addSubview(controller.view)
    }
}
