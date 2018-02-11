//
//  APIRequest.swift
//  BitriseAPI
//
//  Created by Joel Trew on 10/02/2018.
//

import Foundation

protocol APIRequest {
    
    associatedtype Response: Decodable
    
    var endpoint: String? {
        get
    }
    
    var baseUrl: URL {
        get
    }
    
    var urlRequest: URLRequest {
        get
    }
    
    var httpMethod: HTTPMethod {
        get
    }
    
    var headers: [String: String] {
        get
    }
    
    var body: Data? {
        get
        set
    }
    
    func createUrl() -> URL
}

extension APIRequest {
    
    func createUrl() -> URL {
        return baseUrl.appendingPathComponent(endpoint ?? "")
    }

    
    var urlRequest: URLRequest {
        
        var urlRequest = URLRequest(url: createUrl())
        
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
    
    var headers: [String: String] {
        return [String:String]()
    }

    
    mutating func setBody<T: Encodable>(with encodable: T) {
        self.body = try? JSONEncoder().encode(encodable.self)
    }
}


enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}
