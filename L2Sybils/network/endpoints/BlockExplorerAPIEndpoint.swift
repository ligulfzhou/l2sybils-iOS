//
//  BlockExplorerAPIEndpoint.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/12/31.
//

import Combine
import Foundation


enum BlockExplorerAPIEndpoint: APIEndpoint {
    case getTransactions(s: String)
    

    var baseURL: URL {
        return URL(string: "https://block-explorer-api.mainnet.zksync.io")!
    }

    var path: String {
        switch self {
        case .getTransactions(_):
            return "/api"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTransactions(_):
            return .get
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            nil
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case let .getTransactions(s):
            return [
                "module": "account",
                "action": "txlist",
                "address": s,
                "startblock": "0",
                "endblock": "99999999999999",
                "sort": "asc",
                "offset": "1000"

            ]
        }
    }
}

protocol BlockExplorerProtocol {
    func getTransactions(address: String) -> AnyPublisher<TransactionResponse, Error>
}

class BlockExplorerService: BlockExplorerProtocol {
    let apiClient = URLSessionAPIClient<BlockExplorerAPIEndpoint>()
    
    func getTransactions(address: String) -> AnyPublisher<TransactionResponse, Error> {
        // todo: 可能大于 1000
        return apiClient.request(.getTransactions(s: address))
    }
}
