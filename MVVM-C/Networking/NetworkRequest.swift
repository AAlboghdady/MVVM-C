//
//  NetworkRequest.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 09/04/2022.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

var Network = NetworkRequest()

class NetworkRequest {
    
    let disposeBag = DisposeBag()
    
    func sendRequest<T: Codable>(function: ApiManager, model: T.Type, showLoading: Bool = true,
                                  success: @escaping(_ model: T)->(), failure:@escaping (_ errors:String)->()) {
        switch Reachability().connectionStatus() {
        case .unknown, .offline:
            self.showConnectionErrorAlert()
        case .online(.wwan), .online(.wiFi):
//            showLoading()
            let provider = MoyaProvider<ApiManager>()
            provider.rx.request(function)
                .map(T.self)
                .subscribe { (value) in
//                    hideLoading()
                    success(value)
                } onFailure: { (error) in
//                    hideLoading()
                    print(error.localizedDescription)
                    failure(error.localizedDescription)
                }.disposed(by: disposeBag)
        }
    }
    
    func showConnectionErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "No internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: .default, handler: nil))
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }
}
