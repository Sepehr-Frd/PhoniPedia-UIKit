//
//  Spec_+CoreDataClass.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/12/21.
//
//

import Foundation
import CoreData

@objc(Spec_)
public class Spec_: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
      case key
      case val
    }

    required convenience public init(from decoder: Decoder) throws {
      guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
        throw DecoderConfigurationError.missingManagedObjectContext
      }

      self.init(context: context)

      let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decode(String.self, forKey: .key)
        self.val = try container.decode([String].self, forKey: .val)
    }
}
