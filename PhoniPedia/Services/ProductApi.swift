//
//  ProductsApi.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/27/21.
//

import Foundation

class ProductApi {
    
    func getProductUrlSession(url: String, completion: @escaping ProductResponseCompletion) {
        
        guard let url = URL(string: url) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let productObject = try JSONDecoder().decode(ProductDataObject.self, from: data)
                completion(productObject)
                return
            } catch {
                print("couldn't decode json")
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
        }
        task.resume()
    }
}
