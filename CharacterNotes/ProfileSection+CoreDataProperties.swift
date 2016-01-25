//
//  ProfileSection+CoreDataProperties.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/20/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ProfileSection {

    @NSManaged var name: String?
    @NSManaged var quotes: NSSet?
    @NSManaged var character: Character?

}
