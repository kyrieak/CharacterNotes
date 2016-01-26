//
//  NavController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/25/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NavController: UINavigationController {
  required init?(coder aDecoder: NSCoder) {
    NavController.seed()
    
    super.init(coder: aDecoder)
  }
  
  class func seed() {
    let context = getDocumentContext()

    let lists = seedLists(context)
    let books = seedBooks(context)
    // 4, 8, 3
    // 2, 8, 7
    // 6, 3, 4
    lists[0].mutableSetValueForKey("books").addObjectsFromArray([books[0], books[1], books[2]])
    lists[1].mutableSetValueForKey("books").addObjectsFromArray([books[4], books[1], books[8]])
    lists[2].mutableSetValueForKey("books").addObjectsFromArray([books[6], books[2], books[0]])
//    lists[0].books = NSSet(array: [books[0], books[1], books[2]])
//    lists[1].books = NSSet(array: [books[4], books[1], books[8]])
//    lists[2].books = NSSet(array: [books[6], books[2], books[0]])
  }
  
  class func seedLists(context: NSManagedObjectContext) -> [BookList] {
    return [BookList(order: 1, context: context),
            BookList(order: 2, context: context),
            BookList(order: 3, context: context)]
  }
  
  class func seedBooks(context: NSManagedObjectContext) -> [Book] {
    var books: [Book] = []
    let bookOrder = [4, 8, 3, 1, 2, 9, 6, 5, 7]

    for num in bookOrder {
      books.append(Book(order: num, context: context))
    }
    
    return books
  }
  
  private class func getDocumentContext() -> NSManagedObjectContext {
    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    return delegate.getDocumentContext()
  }
}