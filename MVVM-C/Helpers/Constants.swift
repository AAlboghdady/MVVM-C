//
//  Constants.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 09/04/2022.
//

import UIKit

struct Constants {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let uDefaults = UserDefaults.standard
    static var uWindow: UIWindow?
    static let reachability = Reachability()
    
    static let baseURL = "http://api.football-data.org/"
    static let APIURL = "\(Constants.baseURL)v2/"
    static let authToken = "f5b855e16bda46d8911b5b6cdf9f130c"
}
