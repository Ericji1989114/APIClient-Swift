//
//  APIProtocol.swift
//  GithubDM
//
//  Created by Eric JI on 2019/11/27.
//  Copyright © 2019 Eric JI. All rights reserved.
//

import Foundation

public protocol APIProtocol {
    
    var baseUrl: URL? { get }
    
    // model type
    associatedtype ResponseType: Codable
    
    var apiPath: String { get }
    
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var headers: HTTPHeaders? { get }

    var parameters: Parameters? { get }
    
}

// MARK: - Default functions

public extension APIProtocol {
    
    func getAPIRequstUrl() -> URL? {
        
        guard var url = self.baseUrl else {
            return nil
        }
        
        url.appendPathComponent(apiPath)
        
        return url
    }
    
    var encoding: ParameterEncoding {
        return .urlEncoding
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var parameters: Parameters? {
        return nil
    }
    
}

// MARK: - Common Definition

// HTTP Method
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// A dictionary of headers to apply to URLRequest.
public typealias HTTPHeaders = [String: String]

// A dictionary of parameters to apply to URLRequest
public typealias Parameters = [String: Any]

// Encoding method
public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
}
