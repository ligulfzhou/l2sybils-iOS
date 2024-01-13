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

    var isAddressValidPublisher:  AnyPublisher<Bool, Never>  {
        $address.map {
            addr in
            return addr != "" && addr.count == 42 && addr.starts(with: "0x")
        }
        .eraseToAnyPublisher()
    }
    
    private var cancellables = Set<AnyCancellable>()
    let blockExplorerService: BlockExplorerService

    @Published var transactions: [Transaction] = [] {
        didSet {
            
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
}
