//
//  APIManager.swift
//  SocialMediaApp
//
//  Created by Apple on 11/1/21.
//

import Foundation
import Alamofire

class APIManager {
    static let sharedInstance = APIManager()
    
    func call<T: Codable>(type: EndPointType, params: Parameters? = nil, handler: @escaping (T?, String?)->()) {
        guard Reachability.isConnectedToNetwork() else {
            handler(nil, "Check you internet connection")
            return
        }
        print(type.url)
        print(type.httpMethod)
        print(type.headers)
        AF.request(type.url,
                   method: type.httpMethod,
                   parameters: params,
                   encoding: type.encoding,
                   headers: type.headers).validate().responseJSON { data in
            switch data.result {
            case .success(_):
                let decoder = JSONDecoder()
                if let jsonData = data.data {

                    do {
                        let result = try! decoder.decode(T.self, from: jsonData)
                        handler(result, nil)
                    }
                    catch let errorValue {
                        handler(nil, errorValue.localizedDescription)
                    }
                }
                break
            case .failure(let error):
                handler(nil, error.localizedDescription)
                break
            }
        }
    }
}
