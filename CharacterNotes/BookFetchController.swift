//
//  BookFetchController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/21/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData


extension NSSortDescriptor {
  convenience init(key: String, asc: Bool) {
    self.init(key: key, ascending: asc)
  }
}


class BookFetchController: NSFetchedResultsController {
  typealias BookFC   = BookFetchController
  typealias SortDesc = NSSortDescriptor
  
  private var documentContext: NSManagedObjectContext
  private let cacheFileName: String = "books"
  
  override init() {
    documentContext = BookFC.getDocumentContext()
    
    super.init(fetchRequest: BookFC.requestAllBooks(),
                 managedObjectContext: documentContext,
                   sectionNameKeyPath: nil, cacheName: nil)
  }
  
  
  init(inList: BookList) {
    documentContext = BookFC.getDocumentContext()

    super.init(fetchRequest: BookFC.requestBooksInList(inList),
               managedObjectContext: documentContext,
               sectionNameKeyPath: nil, cacheName: nil)
  }
  
  
  init(notInList: BookList) {
    documentContext = BookFC.getDocumentContext()
    
    super.init(fetchRequest: BookFC.requestBooksNotInList(notInList),
                 managedObjectContext: documentContext,
                   sectionNameKeyPath: nil, cacheName: nil)
  }
  
  
  class func requestAllBooks() -> NSFetchRequest {
    let req = NSFetchRequest(entityName: "Book")
    
    req.sortDescriptors = [SortDesc(key: "order", asc: true)]
    
    return req
  }
  
  
  class func requestBooksInList(list: BookList) -> NSFetchRequest {
    let req = NSFetchRequest(entityName: "Book")
    
    req.predicate = NSPredicate(format: "ANY lists == %@", list)
    req.sortDescriptors = [SortDesc(key: "order", asc: true)]
    
    return req
  }

  
  class func requestBooksNotInList(list: BookList) -> NSFetchRequest {
    let req = NSFetchRequest(entityName: "Book")
    
    req.predicate = NSPredicate(format: "NOT (SELF IN %@)", list.books!)
    req.sortDescriptors = [SortDesc(key: "order", asc: true)]
    
    return req
  }
  
  
  private class func getDocumentContext() -> NSManagedObjectContext {
    let delegate = UIApplication.sharedApplication().delegate as! AppDelegate

    return delegate.getDocumentContext()
  }
}