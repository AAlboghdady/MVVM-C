//
//  MatchCell.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 10/04/2022.
//

import UIKit

class MatchCell: UITableViewCell {
    
    private var match: Match?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(match: Match) {
        self.match = match
        addMatchView(match: match)
    }
    
    func addMatchView(match: Match) {
        // loading the MatchView inside the cell
        let controller = UIStoryboard.instantiate(.team, .matchView) as! MatchView
        controller.view.frame = CGRect(x: 8, y: 8, width: contentView.frame.size.width - 16, height: contentView.frame.size.height - 16)
        controller.setupViews(match: match)
        contentView.addSubview(controller.view)
    }
}
