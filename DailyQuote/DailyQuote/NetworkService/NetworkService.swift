//
//  NetworkService.swift
//  DailyQuote
//
//  Created by Jose Cervantes on 11/21/24.
//

import Combine
import Foundation

protocol NetworkServiceProtocol {
    func fetch() -> AnyPublisher<Quote, Error>
}

class NetworkService: NetworkServiceProtocol {
    func fetch() -> AnyPublisher<Quote, Error> {
        guard let url = URL(string: Endpoint.baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Quote].self, decoder: JSONDecoder())
            .map { $0.randomElement()! }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
