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
  typealias Book   = CNBook
  
//  let documentContext = BooksTableDataSource.getDocumentContext()
  var bookList: CNList?
  
  var booksInListFC: BookFC
  
  private(set) var orderMin: Int = 0
  
  override init() {
    booksInListFC = BookFC()
    
    super.init()
    
    performFetch(booksInListFC)
  }
  
  init(list: CNList) {
    bookList = list
    booksInListFC = BookFC(inList: list)
    
    super.init()
    
    performFetch(booksInListFC)
    
    let firstBook = (booksInListFC.fetchedObjects!.first! as! Book)

    if (firstBook.readOrder != nil) {
      orderMin = Int(firstBook.readOrder!)
    }
    
    Log.withLine("-", msg: list.name)
  }
  
  
  func performFetch(fc: BookFC) {
    do {
      try fc.performFetch()
    } catch {
      let query = fc.fetchRequest.predicate?.predicateFormat
      
      Log.withSpace("performFetch for \n\(query)\nfailed:\n\(error)")
    }
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return booksInListFC.sections![0].numberOfObjects
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("bookRow")!
    let book = bookAtIndexPath(indexPath)
    
    if (book.readOrder == nil) {
      if (bookList == nil) {
        book.readOrder = indexPath.row + 1
      } else {
        book.readOrder = orderMin + indexPath.row
      }
    }

    cell.textLabel?.text       = book.title
    cell.detailTextLabel?.text = book.author!.name
    
    return cell
  }
  
  func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  
  func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//    let bookS = bookAtIndexPath(sourceIndexPath)
//    let bookD = bookAtIndexPath(destinationIndexPath)

    if (sourceIndexPath.row < destinationIndexPath.row) {
      Log.withSpace("Dragging down")
    } else {
      Log.withSpace("Dragging up")
    }
  }
  
  func bookAtIndexPath(indexPath: NSIndexPath) -> Book {
    return (booksInListFC.objectAtIndexPath(indexPath) as! Book)
  }
  
  
//  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    if (bookList != nil) {
//      return ((section == 0) ? bookList!.name : "Not In \(bookList!.name)")
//    } else {
//      return "All Books"
//    }
//  }
  
//  private class func getDocumentContext() -> NSManagedObjectContext {
//    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//    
//    return delegate.getDocumentContext()
//  }
}


