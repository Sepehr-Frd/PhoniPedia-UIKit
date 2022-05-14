//
//  Specification_+CoreDataClass.swift
//  SepiRad Online Shop
//
//  Created by Sepehr Foroughi Rad on 10/12/21.
//
//

import Foundation
import CoreData

@objc(Specification_)
public class Specification_: NSManagedObject, Decodable {

    enum CodingKeys: String, CodingKey {
      case title
      case specs
    }

    required convenience public init(from decoder: Decoder) throws {
      guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
        throw DecoderConfigurationError.missingManagedObjectContext
      }

      self.init(context: context)

      let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
      self.specs = try container.decode(Set<Spec_>.self, forKey: .specs) as NSSet

    }
}
