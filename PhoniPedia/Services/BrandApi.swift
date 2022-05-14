//
//  BrandApi.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 9/28/21.
//

import Foundation

class BrandApi {
    
    func getBrandUrlSession(brandName: String, completion: @escaping BrandResponseCompletion) {
    
        guard let url = URL(string: "\(SharedProperties.BASE_BRAND_URL)\(brandName)") else {return}
        
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
                let brandObject = try JSONDecoder().decode(BrandDataObject.self, from: data)
                completion(brandObject)
                return
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
        }
        task.resume()
    }
}





