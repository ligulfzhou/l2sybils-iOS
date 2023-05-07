//
//  TabbarViewModel.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/5.
//

import Foundation
import Combine

class TabbarViewModel: ObservableObject {
    
    @Published private(set) var currentDate = Date()
    @Published private(set) var cancellables: Set<AnyCancellable> = []
    
    func updateCurrentDateOnTabChange(selectedTabPublisher: Published<UIState.Tab>.Publisher) {
        selectedTabPublisher
            .removeDuplicates()
            .sink { [weak self] _ in self?.currentDate = Date() }
            .store(in: &cancellables)
    }
}
