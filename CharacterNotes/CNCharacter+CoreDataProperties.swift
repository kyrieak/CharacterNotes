//
//  CNCharacter+CoreDataProperties.swift
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

extension CNCharacter {

    @NSManaged var ageRangeIsEstimate: NSNumber?
    @NSManaged var ageRangeMax: NSNumber?
    @NSManaged var ageRangeMin: NSNumber?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var middleName: String?
    @NSManaged var species: String?
    @NSManaged var yearRangeIsEstimate: NSNumber?
    @NSManaged var yearRangeMax: NSNumber?
    @NSManaged var yearRangeMin: NSNumber?
    @NSManaged var book: CNBook?
    @NSManaged var group: CNGroup?
    @NSManaged var headings: NSSet?

}
