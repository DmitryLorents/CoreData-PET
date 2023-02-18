//
//  Book+CoreDataProperties.swift
//  CoreData-PET
//
//  Created by Mac on 18.02.2023.
//
//

import Foundation
import CoreData
import UIKit


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var image: UIImage?
    @NSManaged public var name: String?
    @NSManaged public var user: Set<User>?

}

// MARK: Generated accessors for user
extension Book {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension Book : Identifiable {

}
