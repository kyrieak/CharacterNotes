//
//  CNProfile.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/17/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData


class CNProfile: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
  
  func allNames() -> [String] {
    var names: [String] = []
    
    if (firstName != nil) {
      names.append(firstName!)
    }
    if (middleName != nil) {
      names.append(middleName!)
    }
    if (lastName != nil) {
      names.append(lastName!)
    }
    
    return names
  }
  
  func getFullName() -> String {
    return allNames().joinWithSeparator(" ")
  }
}
