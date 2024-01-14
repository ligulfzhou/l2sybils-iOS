//
//  BlockExplorerAPIEndpoint.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/12/31.
//

import Combine
import Foundation


enum BlockExplorerAPIEndpoint: APIEndpoint {
    case getTransactions(address: String)
    case getzkSyncLiteTransactions(address: String)
    case getEraTransfers(address: String)

    var baseURL: URL {
        switch self {
        case .getTransactions(_):
            return URL(string: "https://block-explorer-api.mainnet.zksync.io")!
        case .getzkSyncLiteTransactions(_):
            return URL(string: "https://api.zksync.io")!
        case .getEraTransfers(_):
            return URL(string: "https://block-explorer-api.mainnet.zksync.io")!
        }
    }

    var path: String {
        switch self {
        case .getTransactions(_):
            return "/api"
        case .getzkSyncLiteTransactions(let address):
            return "/api/v0.2/accounts/\(address)/transactions"
        case .getEraTransfers(_):
            return "/api"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTransactions(_):
            return .get
        case .getzkSyncLiteTransactions(_):
            return .get
        case .getEraTransfers(_):
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
        case .getTransactions(let address):
            return [
                "module": "account",
                "action": "txlist",
                "address": address,
                "startblock": "0",
                "endblock": "99999999999999",
                "sort": "asc",
                "offset": "1000"
            ]
        case .getzkSyncLiteTransactions(_):
            return [
                "from": "latest",
                "direction": "older",
                "limit": "100"
            ]
        case .getEraTransfers(let address):
            return [
                "module": "account",
                "action": "tokentx",
                "address": address,
                "sort": "asc",
                "offset": 1000,
                "page": 1,
            ]
        }
    }
}

protocol BlockExplorerProtocol {
    func getTransactions(address: String) -> AnyPublisher<EraTransactionResponse, Error>
    func getLiteTransactions(address: String)-> AnyPublisher<LiteTransactionReponse,Error>
    func getEraTransfers(address: String)-> AnyPublisher<EraTransfer, Error>
}

class BlockExplorerService: BlockExplorerProtocol {
    func getEraTransfers(address: String) -> AnyPublisher<EraTransfer, Error> {
        apiClient.request(.getEraTransfers(address: address))
    }

    func getLiteTransactions(address: String) -> AnyPublisher<LiteTransactionReponse, Error> {
        return apiClient.request(.getzkSyncLiteTransactions(address: address))
    }

    func getTransactions(address: String) -> AnyPublisher<EraTransactionResponse, Error> {
        // todo: 可能大于 1000
        return apiClient.request(.getTransactions(address: address))
    }

    let apiClient = URLSessionAPIClient<BlockExplorerAPIEndpoint>()
}
