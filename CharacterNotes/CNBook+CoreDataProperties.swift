//
//  CNBook+CoreDataProperties.swift
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

extension CNBook {

    @NSManaged var finishedReading: NSNumber?
    @NSManaged var publishDate: NSDate?
    @NSManaged var readOrder: NSNumber?
    @NSManaged var title: String?
    @NSManaged var yearRangeMin: NSNumber?
    @NSManaged var yearRangeMax: NSNumber?
    @NSManaged var yearRangeIsEstimate: NSNumber?
    @NSManaged var author: CNAuthor?
    @NSManaged var characters: NSSet?
    @NSManaged var lists: NSSet?

}
