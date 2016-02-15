//
//  CNHeading.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData


class CNHeading: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

  convenience init(name: String, context: NSManagedObjectContext) {
    self.init(entity: CNHeading.entityDesc(context)!, insertIntoManagedObjectContext: context)
  }
  
  class func entityDesc(context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entityForName("CNHeading", inManagedObjectContext: context)
  }
}
