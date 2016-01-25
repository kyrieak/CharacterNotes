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

class BooksViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  typealias BookFC = BookFetchController
  
  var dataSource: BooksTableDataSource?
  
  override func viewDidLoad() {
    tableView.dataSource = dataSource
    tableView.reloadData()
    
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