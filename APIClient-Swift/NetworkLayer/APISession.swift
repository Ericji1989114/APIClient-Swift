//
//  APISessionManager.swift
//  GithubDM
//
//  Created by Eric JI on 2019/11/27.
//  Copyright © 2019 Eric JI. All rights reserved.
//

import Foundation

public struct APISessionManager {
    
    private let urlSession: URLSession
    
    // MARK: - Initialize
    
    public init(configuration: URLSessionConfiguration) {
        urlSession = URLSession(configuration: configuration)
    }
    
    public func sendRequest<T: APIProtocol>(_ api: T, completion: @escaping (APIResult<T.ResponseType>) -> Void) {
        
        guard let requestUrl = api.getAPIRequstUrl() else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        // url request setting
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = api.method.rawValue
        if let headers = api.headers {
            for (headerField, headerValue) in headers {
                urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
                
        do {
            try APIParameterEncoder().encode(&urlRequest, with: api.parameters ?? [:], encoding: api.encoding)
            
            // call api from url session
            let dataTask = self.urlSession.dataTask(with: urlRequest) { (data, response, error) in

                // guarantee that call back will be handled in main thread
                DispatchQueue.main.async {
                    // System or server error handling
                    guard error == nil else {
                        
                        completion(.failure(APIError.failed))
                        return
                    }
                    
                    if let response = response as? HTTPURLResponse {
                        
                        let statusCode = response.statusCode
                        
                        switch statusCode {
                        case 200...299:
                            // analyze the data. convert it to be a model.
                            
                            // guarantee correct data
                            guard let data = data else  {
                                completion(.failure(.invalidData))
                                return
                            }
                            
                            // guarantee jsonObject is not nil
                            guard let jsonObject = try? JSONDecoder().decode(T.ResponseType.self, from: data) else {
                                completion(.failure(.jsonSerializationFailed))
                                return
                            }
                            
                            // successful case
                            completion(.success(jsonObject))
                            
                        case 401...499:
                            completion(.failure(.authenticationError))
                        case 500...599:
                            completion(.failure(.badRequest))
                        case 600:
                            completion(.failure(.outdated))
                        default:
                            completion(.failure(.failed))
                        }
                        return
                    }
                }
                    
            }
            dataTask.resume()
            
        } catch {
            guard let err = error as? APIError else {
                completion(.failure(.failed))
                return
            }
            completion(.failure(err))
        }
    }
        
}
