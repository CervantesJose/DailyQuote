//
//  QuoteViewModel.swift
//  DailyQuote
//
//  Created by Jose Cervantes on 11/21/24.
//

import Combine
import Foundation

class QuoteViewModel: ObservableObject {
    @Published var quote: Quote? = nil
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchQuote() {
        networkService.fetch()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] quote in
                self?.quote = quote
            })
            .store(in: &cancellables)
    }
}
