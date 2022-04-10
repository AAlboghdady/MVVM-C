//
//  Loading.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 10/04/2022.
//

import UIKit

class Loading {
    
    static var shared = Loading()
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    private let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    
    init() {
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
    }
}
