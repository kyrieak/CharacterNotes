//
//  CNList.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData


class CNList: NSManagedObject {
// Insert code here to add functionality to your managed object subclass

  convenience init(order: Int, context: NSManagedObjectContext) {
    self.init(entity: CNList.entityDesc(context)!,
      insertIntoManagedObjectContext: context)
    
    self.name = "List No. \(order)"
  }
  
  class func entityDesc(context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entityForName("CNList", inManagedObjectContext: context)
  }
  
  func addBooks(books: [CNBook]) {
    self.mutableSetValueForKey("books").addObjectsFromArray(books)
  }
}
