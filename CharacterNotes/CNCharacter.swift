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
    return YearRange(min: ageRangeMin?.integerValue, max: ageRangeMax?.integerValue, isEstimate: (ageRangeIsEstimate?.boolValue ?? true))
  }
  
  var timePeriod: YearRange {
    return YearRange(min: yearRangeMin?.integerValue, max: yearRangeMax?.integerValue, isEstimate: (yearRangeIsEstimate?.boolValue ?? true))
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
  
  var pronounStr: String? {
    if (pronoun == nil) {
      return nil
    } else {
      switch(pronoun!.integerValue) {
        case Pronoun.She.rawValue:
          return "She"
        case Pronoun.He.rawValue:
          return "He"
        default:
          return "Other"
      }
    }
  }
  
  
  convenience init(context: NSManagedObjectContext) {
    self.init(entity: CNCharacter.entityDesc(context)!,
                insertIntoManagedObjectContext: context)
  }
  
  class func entityDesc(context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entityForName("CNCharacter", inManagedObjectContext: context)
  }
  
// Insert code here to add functionality to your managed object subclass
}

struct YearRange {
  var min: Int?
  var max: Int?
  var isEstimate: Bool
  
  var noInfo: Bool {
    return ((min ?? max) == nil)
  }
  
  var isRanged: Bool {
    return (max != min)
  }
  
  init(min: Int?, max: Int?, isEstimate: Bool?) {
    self.min = (min ?? max)
    self.max = (max ?? min)
    self.isEstimate = (isEstimate ?? true)
  }
}


enum Pronoun: Int {
  case She   = 0
  case He    = 1
  case Other = 2
}

struct CharacterInfo {
  var firstName, middleName, lastName: String?
}
