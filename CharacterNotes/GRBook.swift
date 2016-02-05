//
//  GRBook.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/3/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation

struct GRBook {
  var grID: Int?
  var title: String = ""
  var authorNames: [String]
  var shelfNames: [String]
  
  init() {
    self.authorNames = []
    self.shelfNames = []
  }
  
  mutating func setGoodreadsID(id: String) {
    let trimID = id.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    
    grID = Int(trimID)
  }
  
  mutating func addAuthor(name: String) {
    authorNames.append(name)
  }
  
  mutating func addShelf(name: String) {
    shelfNames.append(name)
  }
}

struct GRAuthor {
  var grID: Int?
  var name: String = ""
  
  init() {}
  
  init(name: String) {
    self.name = name
  }
  
  mutating func setGoodreadsID(id: String) {
    let trimID = id.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    
    grID = Int(trimID)
  }
}

struct GRShelf {
  var grID: Int?
  var name: String?
  
  init() {}
  
  init(name: String) {
    self.name = name
  }
}