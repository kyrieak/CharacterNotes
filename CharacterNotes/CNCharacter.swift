//
//  CNCharacter.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData


class CNCharacter: NSManagedObject {
  var fullName: String {
    return allNames().joinWithSeparator(" ")
  }
  
  var depictedAge: YearRange {
    return YearRange(min: ageRangeMin?.integerValue, max: ageRangeMax?.integerValue, isEstimate: ageRangeIsEstimate?.boolValue)
  }
  
  var depictedYear: YearRange {
    return YearRange(min: yearRangeMin?.integerValue, max: yearRangeMax?.integerValue, isEstimate: yearRangeIsEstimate?.boolValue)
  }
  
  private func allNames() -> [String] {
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
  
// Insert code here to add functionality to your managed object subclass
}

struct YearRange {
  var min: Int?
  var max: Int?
  var isEstimate: Bool?
}


enum Pronoun: Int {
  case She   = 0
  case He    = 1
  case Other = 2
}

struct CharacterInfo {
  var firstName, middleName, lastName: String?
}
