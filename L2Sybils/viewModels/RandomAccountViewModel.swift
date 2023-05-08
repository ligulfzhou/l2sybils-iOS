//
//  RandomAccountViewModel.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/7.
//

import Foundation


class RandomAccountViewModel: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var accounts: [KeyPair] = []
    
    
    func fetchRandomAccounts() {
        isLoading = true
        
    }
}
