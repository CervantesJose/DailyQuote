//
//  DailyQuoteTests.swift
//  DailyQuoteTests
//
//  Created by Jose Cervantes on 11/21/24.
//

import Combine
import XCTest
@testable import DailyQuote

final class DailyQuoteViewModelTests: XCTestCase {
    var vm: QuoteViewModel!
    var mockService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        vm = QuoteViewModel(networkService: mockService)
        cancellables = []
    }
    
    override func tearDown() {
        vm = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchQuote_Success() {
        // Arrange
        let expectedQuote = Quote(q: "To test.. or not to test", a: "William Swiftspear")
        mockService.result = .success(expectedQuote)
        
        // Act
        let expectaction = XCTestExpectation(description: "Fetch quote success")
        vm.$quote
            .dropFirst()
            .sink { quote in
                // Assert
                XCTAssertEqual(quote?.q, expectedQuote.q)
                XCTAssertEqual(quote?.a, expectedQuote.a)
                expectaction.fulfill()
            }
            .store(in: &cancellables)
        
        vm.fetchQuote()
        
        wait(for: [expectaction], timeout: 1.0)
    }
    
    func testFetchQuote_Failure() {
        // Arrange
        mockService.result = .failure(URLError(.notConnectedToInternet))
        
        // Act
        let expectaction = XCTestExpectation(description: "Fetch quote failure")
        vm.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                // Assert
                XCTAssertNotNil(errorMessage)
                XCTAssertEqual(errorMessage, URLError(.notConnectedToInternet).localizedDescription)
                expectaction.fulfill()
            }
            .store(in: &cancellables)
        
        vm.fetchQuote()
        
        wait(for: [expectaction], timeout: 1.0)
    }
}
