//
//  APIParameterEncoder.swift
//  GithubDM
//
//  Created by Eric JI on 2019/11/27.
//  Copyright © 2019 Eric JI. All rights reserved.
//

import Foundation

struct APIParameterEncoder {
    
    // MARK: - Internal Function
    func encode(_ urlRequest: inout URLRequest, with parameters: Parameters, encoding: ParameterEncoding) throws {
        
        do {
            switch encoding {
            case .jsonEncoding:
                try self.jsonParameterEncode(&urlRequest, with: parameters)
            case .urlEncoding:
                try self.urlParameterEncode(&urlRequest, with: parameters)
            }
        } catch {
            throw error
        }
    }
    
    // MARK: - Private Functions
    // url encoding
    private func urlParameterEncode(_ urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
                
        guard let url = urlRequest.url else {
            throw APIError.invalidURL
        }
        
        if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? String.httpMethod_get), encodesParametersInURL(with: method) {
            guard let url = urlRequest.url else {
                throw APIError.invalidURL
            }
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                
                var urlQueryItems = [URLQueryItem]()
                for (key,value) in parameters {
                    let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlQueryItems.append(queryItem)
                }
                urlComponents.queryItems = urlQueryItems
                urlRequest.url = urlComponents.url
            }
        } else {
            if urlRequest.value(forHTTPHeaderField: String.requestField_contentType) == nil {
                urlRequest.setValue(String.urlEncoding_form, forHTTPHeaderField: String.requestField_contentType)
            }
            
            let queryString = try queryStringFromURL(url: url, with: parameters)
            urlRequest.httpBody = queryString?.data(using: .utf8)
        }
        
    }
    
    // json encoding
    private func jsonParameterEncode(_ urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            if urlRequest.value(forHTTPHeaderField: String.requestField_contentType) == nil {
                urlRequest.setValue(String.jsonEncoding_form, forHTTPHeaderField: String.requestField_contentType)
            }
        } catch {
            throw APIError.encodingFailed
        }
    }
    
    private func encodesParametersInURL(with method: HTTPMethod) -> Bool {
        switch method {
        case .get:
            return true
        case .post:
            return false
        }
    }
    
    private func queryStringFromURL(url: URL, with parameters: Parameters?) throws -> String? {

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let params = parameters, params.count > 0 {
            
            var urlQueryItems = [URLQueryItem]()
            for key in params.keys {
                var valueString: String? = nil
                let value = params[key]
                if value is String {
                    valueString = value as? String
                } else if let value = value {
                    valueString = (value as AnyObject).description
                }
                let urlQueryItem = URLQueryItem(name: key, value: valueString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                urlQueryItems.append(urlQueryItem)
            }
            
            urlComponents?.queryItems = urlQueryItems
            return urlComponents?.query
        }
        return nil
    }
}

// MARK: - Const
fileprivate extension String {
    
    static let httpMethod_get = "GET"
    static let requestField_contentType = "Content-Type"
    static let urlEncoding_form = "application/x-www-form-urlencoded; charset=utf-8"
    static let jsonEncoding_form = "application/json"

}
