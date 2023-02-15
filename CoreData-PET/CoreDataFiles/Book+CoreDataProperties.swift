//
//  Book+CoreDataProperties.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//
//

import Foundation
import CoreData
import UIKit


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var name: String?
    @NSManaged public var author: String?
    @NSManaged public var image: UIImage?
    @NSManaged public var user: User?

}

extension Book : Identifiable {

}
