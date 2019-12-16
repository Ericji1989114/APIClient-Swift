//
//  APIError.swift
//  GithubDM
//
//  Created by Eric JI on 2019/11/27.
//  Copyright © 2019 Eric JI. All rights reserved.
//

import Foundation

// Common error
public enum APIError: String, Error {
    case parametersNil = "❌　Parameters were nil."
    case encodingFailed = "❌　Parameter encoding failed."
    case invalidURL = "❌　URL is invalid."
    case authenticationError = "❌　Authentication Error"
    case badRequest = "❌　Bad Request"
    case outdated = "❌　The url you requested is outdated."
    case invalidData = "❌　The input data nil or zero length."
    case jsonSerializationFailed = "❌　The json serialization failed."
    case stringSerializationFailed = "❌　The string serialization failed."
    case failed = "❌　Network request failed."
}
