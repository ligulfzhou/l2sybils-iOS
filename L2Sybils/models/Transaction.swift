//
//  Transaction.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/12/31.
//

import Foundation

struct Transaction: Decodable {
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
}

struct TransactionResponse: Decodable {
    public var status: String
    public var message: String
    public var result: [Transaction]
}
