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

class ListsTableDataSource: NSObject, UITableViewDataSource {
  typealias ListFC = ListFetchController
  typealias SortDesc   = NSSortDescriptor
  
  private var fetchController: ListFC
  private(set) var numLists: Int
  
  var lastRow: Int {
    return numLists
  }
  
//  private var documentContext: NSManagedObjectContext


  override init() {
    fetchController = ListFC()
    
    do {
      try fetchController.performFetch()
    } catch {
      NSLog("performFetch on Lists failed\n\n\(error)")
    }

    let numObjects = fetchController.sections?.first?.numberOfObjects

    numLists = ((numObjects == nil) ? 0 : numObjects!)
  }
  
//  
//  func createBookList(order: Int) -> CNList {
//    let list = (NSEntityDescription.insertNewObjectForEntityForName("CNList", inManagedObjectContext: documentContext) as! CNList)
//
//    list.name  = "List No. \(order)"
//
//    return list
//  }
//  
  
  func bookListAtIndexPath(indexPath: NSIndexPath) -> CNList {
    return (fetchController.objectAtIndexPath(indexPath) as! CNList)
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return lastRow + 1
  }

  
  func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return (indexPath.row < lastRow)
  }
  
  
  func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    let maxRow = max(sourceIndexPath.row, destinationIndexPath.row)
    
    if (maxRow < lastRow) {
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
  
  
//  private class func getDocumentContext() -> NSManagedObjectContext {
//    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//    
//    return delegate.getDocumentContext()
//  }
}