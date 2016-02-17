//
//  CNBook.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData


class CNBook: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
  
  convenience init(order: Int, context: NSManagedObjectContext) {
    self.init(entity: CNBook.entityDesc(context)!,
      insertIntoManagedObjectContext: context)
    
    self.readOrder = order
    self.title = "Book No. \(order)"
    if ((order % 2) == 0) {
      self.author = CNAuthor(firstName: nil, lastName: "Any Author", context: context)
    } else {
      self.author = CNAuthor(firstName: nil, lastName: "Bonnie Baker", context: context)
    }
  }
  
  convenience init(title: String, context: NSManagedObjectContext) {
    self.init(entity: CNBook.entityDesc(context)!,
      insertIntoManagedObjectContext: context)

    self.title = title
  }
  
  class func entityDesc(context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entityForName("CNBook", inManagedObjectContext: context)
  }

}
