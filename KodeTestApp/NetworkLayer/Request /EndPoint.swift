//
//  EndPoint.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 12.02.2022.
//

import Foundation

typealias HTTPHeaders = [String: String]

protocol Endpoint {
    var path: String                  { get }
    var httpMethod: HTTPMethod        { get }
    var headers: HTTPHeaders?         { get }
    var body: Encodable?              { get }
    var queryItems: [URLQueryItem]?   { get }
}

// MARK: - Request Setup
extension Endpoint {
    var baseUrlString: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String
        else { fatalError("baseURL could not be configured.") }
        return value
    }
    
    var urlComponents: URLComponents {
        guard var component = URLComponents(string: baseUrlString)
        else { fatalError("baseURL could not be configured.") }
        
        component.path = path
        component.queryItems = queryItems
        return component
    }
    
    var request: URLRequest {
        guard let url = urlComponents.url else { fatalError("baseURL could not be configured.") }
        var request = URLRequest(url: url)
        
        request.httpMethod  = httpMethod.rawValue
        
        if let body = body as? Data {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let headers = headers {
            for(headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        
        request.httpShouldHandleCookies = true
        return request
    }
}
