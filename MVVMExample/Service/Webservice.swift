//
//  Webservice.swift
//  MVVMExample
//
//  Created by Weerawut Chaiyasomboon on 03/03/2568.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case decodedError
}

class Webservice {
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw NetworkError.badURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        do {
            let products = try JSONDecoder().decode([Product].self, from: data)
            return products
        } catch {
            throw NetworkError.decodedError
        }
    }
}
