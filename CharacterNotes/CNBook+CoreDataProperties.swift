//
//  CNBook+CoreDataProperties.swift
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

extension CNBook {

  @NSManaged var title: String
  @NSManaged var author: CNAuthor?
  @NSManaged var publishDate: NSDate?

  @NSManaged var characters: NSSet?
  @NSManaged var settingStartDate: NSDate?
  @NSManaged var settingEndDate: NSDate?

  @NSManaged var readOrder: NSNumber?
  @NSManaged var finishedReading: NSNumber?
  @NSManaged var lists: NSSet?
}
