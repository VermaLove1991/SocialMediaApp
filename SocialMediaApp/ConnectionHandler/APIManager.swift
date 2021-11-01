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
            case .failure(_):
                handler(nil, "self.parseApiError(data: data.data)")
                break
            }
        }
    }
}
