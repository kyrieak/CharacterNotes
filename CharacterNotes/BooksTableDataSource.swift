//
//  BooksTableDataSource.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/24/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class BooksTableDataSource: NSObject, UITableViewDataSource {
  typealias BookFC = BookFetchController
  
  let documentContext = BooksTableDataSource.getDocumentContext()
  var bookList: BookList?
  
  var booksInListFC: BookFC
  var booksNotInListFC: BookFC?
  
  override init() {
    BooksTableDataSource.seed(nil)

    booksInListFC = BookFC()
    
    super.init()
    
    performFetch(booksInListFC)
  }
  
  init(list: BookList) {
    BooksTableDataSource.seed(list)

    bookList = list
    booksInListFC = BookFC(inList: list)
    booksNotInListFC = BookFC(notInList: list)
    
    super.init()
    
    performFetch(booksInListFC)
    performFetch(booksNotInListFC!)
  }
  
  class func seed(list: BookList?) {
    let booksInList = [createBook(4), createBook(8), createBook(3)]
    
    let _ = [createBook(1), createBook(2), createBook(9), createBook(6), createBook(5), createBook(7)]
    
    if (list == nil) {
    } else {
      list!.books = NSSet(array: booksInList)
    }
  }
  
  class func createBook(order: Int) -> Book {
    let context = getDocumentContext()
    return Book(order: order, context: context)
  }
  
  func performFetch(fc: BookFC) {
    do {
      try fc.performFetch()
    } catch {
      let query = fc.fetchRequest.predicate?.predicateFormat

      NSLog("performFetch for \n\(query)\nfailed:\n\(error)")
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return ((bookList == nil) ? 1 : 2)
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (section == 0) {
      
      return booksInListFC.sections![0].numberOfObjects
    } else {
      return booksNotInListFC!.sections![0].numberOfObjects
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("bookRow")!
    let book = bookAtIndexPath(indexPath)

    cell.textLabel?.text       = book.title
    cell.detailTextLabel?.text = book.author
    
    return cell
  }
  
  func bookAtIndexPath(indexPath: NSIndexPath) -> Book {
    
    if (indexPath.section == 0) {
      return (booksInListFC.objectAtIndexPath(indexPath) as! Book)
    } else {
      let idxPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
      return (booksNotInListFC!.objectAtIndexPath(idxPath) as! Book)
    }
  }
  
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if (bookList != nil) {
      return ((section == 0) ? bookList!.name : "Not In \(bookList!.name)")
    } else {
      return "All Books"
    }
  }
  
  private class func getDocumentContext() -> NSManagedObjectContext {
    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    return delegate.getDocumentContext()
  }
}


