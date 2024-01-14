//
//  zkSyncEndpoint.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/12/29.
//
import Combine
import Foundation


enum zkSyncEndpoint: APIEndpoint {
    case getUsers

    var baseURL: URL {
        return URL(string: "https://example.com/api")!
    }

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getUsers:
            return ["Authorization": "Bearer TOKEN"]
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .getUsers:
            return ["page": 1, "limit": 10]
        }
    }
}
