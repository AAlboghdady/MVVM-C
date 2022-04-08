//
//  LeagueView.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit
import Nuke

class LeagueView: UIViewController {

    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupViews(name: String, image: String) {
        nameLabel.text = name
        if let url = URL(string: image) {
            Nuke.loadImage(with: url, into: leagueImageView)
        }
    }
}
