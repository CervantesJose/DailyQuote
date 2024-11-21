//
//  Quote.swift
//  DailyQuote
//
//  Created by Jose Cervantes on 11/21/24.
//

import Foundation

struct Quote: Decodable, Identifiable {
    var id: String { q }
    var q: String
    var a: String
}