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
        guard let url = URL(string: image) else { return }
        Nuke.loadImage(with: url, into: leagueImageView)
    }
}
