//
//  SavedProductDataObject+CoreDataProperties.swift
//  PhoniPedia
//
//  Created by Sepehr Foroughi Rad on 11/10/21.
//
//

import Foundation
import CoreData


extension SavedProductDataObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedProductDataObject> {
        return NSFetchRequest<SavedProductDataObject>(entityName: "SavedProductDataObject")
    }

    @NSManaged public var phoneImage: String?
    @NSManaged public var phoneName: String?
    @NSManaged public var brandName: String?

}

extension SavedProductDataObject : Identifiable {

}
