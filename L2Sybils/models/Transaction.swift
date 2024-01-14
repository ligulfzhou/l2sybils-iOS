//
//  Transaction.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/12/31.
//

import Foundation


struct EraTransfer: Decodable {
    public var blockNumber: String
    public var timeStamp: String
    public var hash: String
    public var nonce: String
    public var blockHash: String
    public var transactionIndex: String
    public var from: String
    public var to: String
    public var value: String
    public var tokenName: String
    public var tokenSymbol: String
    public var tokenDecimal: String
    public var gas: String
    public var gasPrice: String
    public var input: String
    public var contractAddress: String
    public var cumulativeGasUsed: String
    public var gasUsed: String
    public var confirmations: String
    public var fee: String
    public var l1BatchNumber: String
    public var transactionType: String
    public var transferPrice: Double
}

struct EraTransaction: Decodable {
    public var blockNumber: String
    public var timeStamp: String
    public var hash: String
    public var nonce: String
    public var blockHash: String
    public var transactionIndex: String
    public var from: String
    public var to: String
    public var value: String
    public var gas: String
    public var gasPrice: String
    public var isError: String
    public var txreceipt_status: String
    public var input: String
    public var contractAddress: String?
    public var cumulativeGasUsed: String
    public var gasUsed: String
    public var confirmations: String
    public var fee: String
    public var commitTxHash: String
    public var proveTxHash: String
    public var executeTxHash: String
    public var isL1Originated: String
    public var l1BatchNumber: String
    public var type: String
    public var methodId: String
    public var functionName: String
    public var transfers: [EraTransfer]?
}

struct EraTransactionResponse: Decodable {
    public var status: String
    public var message: String
    public var result: [EraTransaction]
}


struct Op: Decodable {
    public var type: String
    public var accountId: Int
    public var account: String
    public var newPkHash: String
    public var feeToken: Int
    public var fee: String
    public var nonce: Int
}

struct LiteTransaction: Decodable {
    public var txHash: String
    public var blockIndex: Int
    public var blockNumber: Int
    public var op: Op
    public var ethSignature: String
    public var status: String
    public var failReason: String?
    public var createdAt: String
    public var batchId: Int
}

struct LiteTransactionReponse: Decodable {
    struct listTransactions: Decodable {
        public var list: [LiteTransaction]
    }
    
    public var result: listTransactions
    public var status: String
    public var error: String?
    
//    private enum Decode
}

struct StatTotalAndChange {
    public var change: Float
    public var total: Float
}

struct IntStatTotalAndChange {
    public var change: Float
    public var total: Float
}
