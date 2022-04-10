//
//  UIViewControllerExtension.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 10/04/2022.
//

import Foundation
import UIKit
import ProgressHUD

extension UIViewController {
    func showErrorAlert(title: String) {
        let alert = UIAlertController(title: "Error", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoading(_ bool: Bool) {
        if bool {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
}
