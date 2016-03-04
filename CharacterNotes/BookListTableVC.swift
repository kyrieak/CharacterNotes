//
//  BooksViewController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/22/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BookListTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
  typealias BookFC = BookFetchController
  
  var dataSource: BooksTableDataSource?
  
  override func viewDidLoad() {
    tableView.dataSource = dataSource
    tableView.reloadData()

    if (dataSource?.bookList == nil) {
      navigationItem.title = "All Books"
    } else {
      navigationItem.title = "\(dataSource!.bookList!.name)"
    }
    
    super.viewDidLoad()
  }
  
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch(type) {
      case .Insert:
        tableView.reloadSections(NSIndexSet(index: indexPath!.section), withRowAnimation: UITableViewRowAnimation.Bottom)
      case .Move:
        tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
      default:
        NSLog("type: \(type)")
    }
  }
  
}