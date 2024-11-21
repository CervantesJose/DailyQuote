//
//  MockNetworkService.swift
//  DailyQuote
//
//  Created by Jose Cervantes on 11/21/24.
//

import Combine
import Foundation

class MockNetworkService: NetworkServiceProtocol {
    var result: Result<Quote, Error> = .failure(URLError(.notConnectedToInternet))
    
    func fetch() -> AnyPublisher<Quote, Error> {
        return result
            .publisher
            .eraseToAnyPublisher()
    }
}
