//
//  EndPoint.swift
//  SocialMediaApp
//
//  Created by Apple on 11/1/21.
//

import Foundation
import Alamofire

class ErrorObject: Codable {
    let message: String
    let key: String?
}

protocol EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
}

enum EndpointItem {
    
    // MARK: User actions
    case otherFollowers(username: String)
    case otherFollowing(username: String)
    case followers
    case user
    case otherUser(username: String)
    case authorizations
    case following
    case search(q: String, order: String, page: Int)
    case followUser(username: String)
    case unfollowUser(username: String)
}

extension EndpointItem: EndPointType {
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    
    // MARK: - Vars & Lets
    
    var path: String {
        switch self {
        case .otherFollowers(let userName):
            return "users/\(userName)/followers"
        case .otherFollowing(let userName):
            return "users/\(userName)/followers"
        case .followers:
            return "user/followers"
        case .following:
            return "user/following"
        case .user:
            return "user"
        case .otherUser(let userName):
            return "users/\(userName)"
        case .authorizations:
            return "authorizations"
        case .search(let q, let order, let page):
            return "search/users?q=\(q)&\(order),\(page)"
        case .followUser(let username):
            return "user/following/\(username)"
        case .unfollowUser(let username):
            return "user/following/\(username)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .followUser(username: let user):
            return .put
        case .unfollowUser(username: let user):
            return .delete
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return [
                "Authorization": "token \(KeyConstant.ApplicationKeys.gitHubAuthToken.rawValue)",
                "Content-Type": "application/json"]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
}

