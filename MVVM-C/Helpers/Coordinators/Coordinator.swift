//
//  Coordinator.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 08/04/2022.
//

import UIKit

protocol Coordinator {
    var navigationController : UINavigationController { get set }
    
    func start()
}
