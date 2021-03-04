//
//  APIEndPoint.swift
//  PryanikyTest
//
//  Created by Игорь Дикань on 04.03.2021.
//

import Moya

enum APIEndPoint {
    case listData(request: ListDataRequest)
}

struct TargetProvider: TargetType {
    
    var type: APIEndPoint
    private var defaults: UserDefaults
    
    init(with type: APIEndPoint) {
        self.type = type
        defaults = .standard
    }
    
    public mutating func handle(for type: APIEndPoint) {
        self.type = type
    }
}

extension TargetProvider {
    
    var baseHeaders: [String: String]? {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
    var headers: [String: String]? {
        guard let newHeaders = baseHeaders else {
            return baseHeaders
        }
        switch type {
        default:
            break
        }
        return newHeaders
    }
    
    var baseURL: URL {
        switch type {
        case .listData:
            return URL(string: "https://pryaniky.com")!
        }
        
    }
    var path: String {
        switch type {
        case .listData:
            return "/static/json/sample.json"
        }
    }
    var method: Moya.Method {
        switch type {
        default:
            return .get
        }
    }
    var methodDesc: String {
        switch method {
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        default:
            return "GET"
        }
    }
    var parameters: [String: Any]? {
        switch type {
        case .listData:
            return nil
        }
    }
    var task: Task {
        switch type {
        default:
            return .requestPlain
        }
    }
    var sampleData: Data {
        return Data()
    }
}
