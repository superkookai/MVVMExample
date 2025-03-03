//
//  ProductListViewModel.swift
//  MVVMExample
//
//  Created by Weerawut Chaiyasomboon on 03/03/2568.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
    let webService: Webservice
    
    init(webService: Webservice) {
        self.webService = webService
    }
    
    @Published var products: [ProductViewModel] = []
    
    func populateProducts() async {
        do {
            let products = try await webService.getProducts()
            self.products = products.map(ProductViewModel.init(product:))
        } catch {
            print("DEBUG: Error getting Products \(error.localizedDescription)")
        }
    }
}

struct ProductViewModel: Identifiable {
    private var product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var id: Int {
        product.id
    }
    
    var title: String {
        product.title
    }
    
    var price: Double {
        product.price
    }
}
