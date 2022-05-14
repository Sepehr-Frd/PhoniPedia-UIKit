//
//  SpecialFiltersApi.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/8/21.
//

import Foundation

class SpecialFiltersApi {
    
    func getSpecialFiltersUrlSession(filterSlug: String, completion: @escaping SpecialFiltersResponseCompletion){
        
        guard let url = URL(string: "\(SharedProperties.BASE_URL)\(filterSlug)") else {return}
        
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
                let specialProductObject = try JSONDecoder().decode(SpecialDataObject.self, from: data)
                completion(specialProductObject)
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

