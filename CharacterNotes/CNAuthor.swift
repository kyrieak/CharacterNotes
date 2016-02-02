//
//  CNAuthor.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData


class CNAuthor: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

  var name: String {
    if (firstName == nil) {
      return lastName
    } else {
      return "\(firstName) \(lastName)"
    }
  }
  
  convenience init(firstName: String?, lastName: String, context: NSManagedObjectContext) {
    self.init(entity: CNAuthor.entityDesc(context)!, insertIntoManagedObjectContext: context)

    self.firstName = firstName
    self.lastName  = lastName
  }
  
  class func entityDesc(context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entityForName("CNAuthor", inManagedObjectContext: context)
  }
}
