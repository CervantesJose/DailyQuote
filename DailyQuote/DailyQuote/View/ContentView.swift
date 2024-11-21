//
//  ContentView.swift
//  DailyQuote
//
//  Created by Jose Cervantes on 11/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = QuoteViewModel()
    
    var body: some View {
        VStack {
            if let quote = vm.quote {
                Text("\"\(quote.q)\"")
                    .font(.title)
                    .padding()
                    .accessibilityLabel("Quote of the Day")
                    .accessibilityValue(quote.q)
                Text("- \(quote.a)")
                    .font(.subheadline)
                    .padding(.bottom)
                    .accessibilityLabel("Author")
                    .accessibilityValue(quote.a)
            } else if let error = vm.errorMessage {
                Text("Error: \(error)")
                    .foregroundStyle(.red)
                    .padding()
                    .accessibilityLabel("Error")
                    .accessibilityValue(error)
            } else {
                ProgressView()
                    .accessibilityLabel("Loading quote")
            }
        }
        .onAppear {
            vm.fetchQuote()
        }
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    ContentView()
}
