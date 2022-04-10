//
//  ApiManager.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 09/04/2022.
//

import Moya
import Alamofire

enum ApiManager {
    case competitions
    case teams(competitionId: Int)
    case matches(teamId: Int)
}

// MARK: - TargetType Protocol Implementation
extension ApiManager: TargetType {
    var baseURL: URL {
        return URL(string: Constants.APIURL)!
    }
    
    var path: String {
        switch self {
        case .competitions:
            return "competitions"
        case .teams(let competitionId):
            return "competitions/\(competitionId)/teams"
        case .matches(let teamId):
            return "teams/\(teamId)/matches"
        }
    }
    
    var parameters: [String: Any]? {
        return [:]
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.queryString)
    }
    
    var headers: [String: String]? {
        var headers = [String: String]()
        switch self {
        case .teams, .matches:
            headers["X-Auth-Token"] = Constants.authToken
        default:
            break
        }
        return headers
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var manager: Data {
        return Data()
    }
}

