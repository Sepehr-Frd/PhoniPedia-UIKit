//
//  ProductDataObject_+CoreDataClass.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/12/21.
//
//

import Foundation
import CoreData

@objc(ProductDataObject_)
public class ProductDataObject_: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
      case data
    }

    required convenience public init(from decoder: Decoder) throws {
      guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
        throw DecoderConfigurationError.missingManagedObjectContext
      }

      self.init(context: context)

      let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(ProductDetailsList_.self, forKey: .data)
    }
}
