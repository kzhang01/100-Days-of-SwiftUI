//
//  Contact+CoreDataProperties.swift
//  RememberName
//
//  Created by Karina Zhang on 1/6/21.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

    var wrappedID: UUID { id ?? UUID() }
    var wrappedName: String { name ?? "Unknown name" }
}

extension Contact : Identifiable {

}
