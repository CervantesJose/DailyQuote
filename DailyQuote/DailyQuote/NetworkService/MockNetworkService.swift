//
//  MockNetworkService.swift
//  DailyQuote
//
//  Created by Jose Cervantes on 11/21/24.
//

import Combine
import Foundation

class MockNetworkService: NetworkServiceProtocol {
    var result: Result<Any, Error> = .failure(URLError(.notConnectedToInternet))
    
    func fetch<T: Codable>(type: T.Type) -> AnyPublisher<T, Error> {
        switch result {
        case .success(let success):
            guard let data = success as? T else {
                return Fail(error: URLError(.cannotDecodeContentData)).eraseToAnyPublisher()
            }
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let failure):
            return Fail(error: failure).eraseToAnyPublisher()
        }
    }
}
