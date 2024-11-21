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
                Text("- \(quote.a)")
                    .font(.subheadline)
                    .padding(.bottom)
            }
        }
        .onAppear {
            vm.fetchQuote()
        }
    }
}

#Preview {
    ContentView()
}
