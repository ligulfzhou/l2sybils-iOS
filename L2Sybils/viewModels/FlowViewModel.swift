//
//  FlowViewModel.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/12/31.
//

import Combine
import Foundation


class FlowViewModel: ObservableObject {
    
    @Published var address = "" {
        didSet {
            self.fetchTransaction(address: address)
        }
    }

    @Published var interaction: StatTotalAndChange? = nil
    @Published var volume: StatTotalAndChange? = nil
    @Published var fee: StatTotalAndChange? = nil
    @Published var contract: StatTotalAndChange? = nil
    
    var isAddressValidPublisher:  AnyPublisher<Bool, Never>  {
        $address.map {
            addr in
            return addr != "" && addr.count == 42 && addr.starts(with: "0x")
        }
        .eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    let blockExplorerService: BlockExplorerService
    
    @Published var transactions: [EraTransaction] = [] {
        didSet {
            getInteraction(address: address, transactions: transactions)
        }
    }
    
    init() {
        self.blockExplorerService = BlockExplorerService()
    }
    
    func fetchTransaction(address: String) {
        self.blockExplorerService.getTransactions(address: address)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { data in
                    print("receiveCompletion....")
                    print(data)
                },
                receiveValue: {[weak self] data in
                    print("receiveValue....")
                    self?.transactions = data.result
                }
            )
            .store(in: &cancellables)
    }

    func getInteraction(address: String, transactions: [EraTransaction]) {
        var stat =  StatTotalAndChange(change: 0.0, total: 0.0)
        let curTimestamp = Date().timeIntervalSince1970

        for transaction in transactions {
            if transaction.from.lowercased() == address.lowercased() {
                stat.total += 1.0
            }
            let gap = curTimestamp - (Double(transaction.timeStamp) ?? 0.0)
            if gap <=  60.0 * 60 * 24 * 7 {
                stat.change += 1.0
            }
        }

        print("interaction: t: \(stat.total), c: \(stat.change)")
        interaction = stat
    }
    
    func getVolumn(transactions: [EraTransaction]) {
        var stat = StatTotalAndChange(change: 0.0, total: 0.0)
        let curTimestamp = Date().timeIntervalSince1970

        for transaction in transactions {
//            volume.total += transaction
        }
    }
}
