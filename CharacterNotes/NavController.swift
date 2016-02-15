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

class NavController: UINavigationController, UINavigationControllerDelegate {
  typealias Book = CNBook
  typealias List = CNList
  
  required init?(coder aDecoder: NSCoder) {
    NavController.seed()

    super.init(coder: aDecoder)
    delegate = self
  }
  
  
  class func seed() {
    let context = getDocumentContext()
    let lists = seedLists(context)
    let books = seedBooks(context)
    // 4, 8, 3
    // 2, 8, 7
    // 6, 3, 4
    lists[0].addBooks([books[0], books[1], books[2]])
    lists[1].addBooks([books[4], books[1], books[8]])
    lists[2].addBooks([books[6], books[2], books[0]])
  }
  
  class func seedLists(context: NSManagedObjectContext) -> [List] {
    return [List(order: 1, context: context),
            List(order: 2, context: context),
            List(order: 3, context: context)]
  }
  
  class func seedBooks(context: NSManagedObjectContext) -> [Book] {
    var books: [Book] = []
    let bookOrder = [4, 8, 3, 1, 2, 9, 6, 5, 7]

    for num in bookOrder {
      books.append(Book(order: num, context: context))
    }
    
    return books
  }
  
  class func seedHeadings(context: NSManagedObjectContext) -> [CNHeading] {
    let h1 = CNHeading(name: "Visual Traits", context: context)
    let h2 = CNHeading(name: "Vocal Traits", context: context)
    let h3 = CNHeading(name: "Olfactory Traits", context: context)
    let h4 = CNHeading(name: "Personality", context: context)
    let h5 = CNHeading(name: "Years, Dates, Times", context: context)
    
    return [h1, h2, h3, h4, h5]
  }

  func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
    Log.withLine("*", msg: "\(viewController)\nand nav controller is: \(viewController.navigationController)")
  }
  
  private class func getDocumentContext() -> NSManagedObjectContext {
    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    return delegate.getDocumentContext()
  }
}