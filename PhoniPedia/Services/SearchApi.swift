//
//  SearchApi.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/11/21.
//

import Foundation

class SearchApi {
    
    func searchWithNameUrlSession(phoneName: String, completion: @escaping BrandResponseCompletion){
        guard let searchUrl = ("\(SharedProperties.SEARCH_URL)\(phoneName)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: searchUrl) else {return}
        
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
