//
//  CNCharacter+CoreDataProperties.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CNCharacter {

    @NSManaged var name: String
    @NSManaged var book: CNBook
    @NSManaged var group: CNGroup?
    @NSManaged var headings: NSSet?

}
