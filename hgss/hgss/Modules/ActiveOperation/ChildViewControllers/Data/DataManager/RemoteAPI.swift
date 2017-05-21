//
//  RemoteAPI.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    case feed(id: Int)
    case map(id: Int)
    case details(id: Int)
    
    static let baseURLString = "http://192.168.201.41:8000"
    
    var method: HTTPMethod {
        switch self {
        case .feed:
            return .get
        case .map:
            return .get
        case .details:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .feed(let id):
            return "/api/mobile/feed/\(id)"
        case .map(let id):
            return "/api/mobile/map/\(id)"
        case .details(let id):
            return "/api/mobile/detail/\(id)"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        default:
            break
        }
        
        return urlRequest
    }
}
