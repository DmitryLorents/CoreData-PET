//
//  User+CoreDataProperties.swift
//  CoreData-PET
//
//  Created by Mac on 18.02.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var book: Book?

}

extension User : Identifiable {

}
