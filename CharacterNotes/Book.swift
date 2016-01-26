//
//  Book.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/20/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData


class Book: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
  
  convenience init(order: Int, context: NSManagedObjectContext) {
    self.init(entity: Book.entityDesc(context)!,
                 insertIntoManagedObjectContext: context)

    self.order = order
    self.title = "Book No. \(order)"
    self.author = "Any Author"
  }
  
  class func entityDesc(context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entityForName("Book", inManagedObjectContext: context)
  }
  
  func isOrderedBefore(otherBook: Book) -> Bool {
    if (self.order == nil) {
      return false
    } else if (otherBook.order == nil) {
      return true
    } else {
      return (self.order!.integerValue < otherBook.order!.integerValue)
    }
  }
}