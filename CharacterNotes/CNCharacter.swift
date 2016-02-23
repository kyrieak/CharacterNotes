//
//  CNCharacter.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData


class CNCharacter: CNProfile {
  
  // - MARK: - private
  
  private var yearMin: NSNumber? {
    return (self.yearRangeMin ?? self.book?.yearRangeMin)
  }
  
  private var yearMax: NSNumber? {
    return (self.yearRangeMax ?? self.book?.yearRangeMax)
  }
  
  private var yearIsEst: Bool {
    if (self.yearRangeIsEstimate != nil) {
      return self.yearRangeIsEstimate!.boolValue
    } else {
      return (self.book?.yearRangeIsEstimate?.boolValue ?? true)
    }
  }

  
  // - MARK: - Initializer

  convenience init(context: NSManagedObjectContext) {
    self.init(entity: CNCharacter.entityDesc(context)!,
                insertIntoManagedObjectContext: context)
  }

  // - MARK: - Instance
  
  func getAgeRange() -> YearRange {
    return YearRange(min: ageRangeMin?.integerValue, max: ageRangeMax?.integerValue, isEstimate: (ageRangeIsEstimate?.boolValue ?? true))
  }
  
  func getTimePeriod() -> YearRange {
    return YearRange(min: self.yearMin?.integerValue, max: self.yearMax?.integerValue, isEstimate: self.yearIsEst)
  }
  
  // - MARK: - Class

  class func entityDesc(context: NSManagedObjectContext) -> NSEntityDescription? {
    return NSEntityDescription.entityForName("CNCharacter", inManagedObjectContext: context)
  }

  // - MARK: -
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