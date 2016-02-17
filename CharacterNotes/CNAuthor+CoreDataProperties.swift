//
//  CNAuthor+CoreDataProperties.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/16/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CNAuthor {

    @NSManaged var dateRangeMin: NSDate?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var dateRangeMax: NSDate?
    @NSManaged var books: NSSet?

}
