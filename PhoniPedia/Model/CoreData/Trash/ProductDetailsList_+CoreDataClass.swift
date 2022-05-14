//
//  ProductDetailsList_+CoreDataClass.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/12/21.
//
//

import Foundation
import CoreData

@objc(ProductDetailsList_)
public class ProductDetailsList_: NSManagedObject, Decodable {
    
    
    enum CodingKeys: String, CodingKey {
        case brand
        case phoneName = "phone_name"
        case phoneImages = "phone_images"
        case thumbnail
        case releaseDate = "release_date"
        case os
        case specifications
    }
        
    required convenience public init(from decoder: Decoder) throws {
      guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
        throw DecoderConfigurationError.missingManagedObjectContext
      }

      self.init(context: context)

      let container = try decoder.container(keyedBy: CodingKeys.self)
        self.brand = try container.decode(String.self, forKey: .brand)
        self.phoneName = try container.decode(String.self, forKey: .phoneName)
        self.phoneImages = try container.decode([String].self, forKey: .phoneImages)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.os = try container.decode(String.self, forKey: .os)
        self.specifications = try container.decode(Set<Specification_>.self, forKey: .specifications) as NSSet

    }
}
