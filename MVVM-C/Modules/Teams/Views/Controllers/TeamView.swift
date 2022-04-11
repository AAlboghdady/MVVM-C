//
//  TeamView.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 09/04/2022.
//

import UIKit
import Nuke

class TeamView: UIViewController {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupViews(name: String, image: String) {
        nameLabel.text = name
        guard let url = URL(string: image) else { return }
        Nuke.loadImage(with: url, into: teamImageView)
    }
}
