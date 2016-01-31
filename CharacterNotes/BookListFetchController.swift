//
//  BooksDataSource.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/18/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BookListFetchController: NSFetchedResultsController, UITableViewDataSource {
  typealias BookListFC = BookListFetchController
  typealias SortDesc   = NSSortDescriptor
  
  private(set) var numLists: Int = 0
  
  var lastRow: Int {
    return numLists
  }
  
  private var documentContext: NSManagedObjectContext

  override init() {
    documentContext = BookListFetchController.getDocumentContext()
    
    super.init(fetchRequest: BookListFC.requestAllLists(),
                 managedObjectContext: documentContext,
                   sectionNameKeyPath: nil, cacheName: nil)
    fetchLists()
  }
  
  
  class func requestAllLists() -> NSFetchRequest {
    let req = NSFetchRequest(entityName: "BookList")
    
    req.sortDescriptors = [SortDesc(key: "order", asc: true)]
    req.fetchBatchSize  = 20
    
    return req
  }
  
  
  func fetchLists() {
//    seed()
    do {
      try performFetch()
    } catch {
      NSLog("performFetch failed")
    }
    
    numLists = sections!.first!.numberOfObjects
  }
  
  
  func createBookList(order: Int) -> BookList {
    let list = (NSEntityDescription.insertNewObjectForEntityForName("BookList", inManagedObjectContext: documentContext) as! BookList)

    list.order = order
    list.name  = "List No. \(order)"

    return list
  }
  
  
  func bookListAtIndexPath(indexPath: NSIndexPath) -> BookList {
    return (objectAtIndexPath(indexPath) as! BookList)
  }

//  
//  func seed() {
//    createBookList(1)
//    createBookList(2)
//    createBookList(3)
//  }
  
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return (indexPath.row < lastRow)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lastRow + 1
  }
  
  func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    let maxRow = max(sourceIndexPath.row, destinationIndexPath.row)

    if (maxRow < lastRow) {
      let bookD  = bookListAtIndexPath(destinationIndexPath)
      let bookS  = bookListAtIndexPath(sourceIndexPath)
      let orderD = bookD.order

      bookD.order = bookS.order
      bookS.order = orderD
      
      tableView.moveRowAtIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)
    }
  }

  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("bookListRow", forIndexPath: indexPath)
    
    if (indexPath.row < lastRow) {
      let list = bookListAtIndexPath(indexPath)
      
      cell.textLabel?.text = list.name
    } else {
      cell.textLabel?.text = "All Books"
    }

    return cell
  }
  
  
  private class func getDocumentContext() -> NSManagedObjectContext {
    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    return delegate.getDocumentContext()
  }
}