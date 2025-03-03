//
//  ContentView.swift
//  MVVMExample
//
//  Created by Weerawut Chaiyasomboon on 03/03/2568.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ProductListViewModel(webService: Webservice())
    
    var body: some View {
        List(vm.products) { product in
            HStack {
                Text(product.title)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(maxWidth: 200,alignment: .leading)
                
                Spacer()
                
                Text("Price: \(Int(product.price))")
            }
        }
        .listStyle(.plain)
        .task {
            await vm.populateProducts()
        }
    }
}

#Preview {
    ContentView()
}
