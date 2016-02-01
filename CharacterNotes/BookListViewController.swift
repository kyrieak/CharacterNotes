//
//  BookListViewController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/21/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BookListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  typealias BookListFC = BookListFetchController

  var selectedList: BookList?
  var dataSource = BookListFC()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = dataSource
  }
  
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if (indexPath.row < (tableView.numberOfRowsInSection(0) - 1)) {
      selectedList = dataSource.bookListAtIndexPath(indexPath)
    } else {
      selectedList = nil
    }

    performSegueWithIdentifier("segueToBooks", sender: nil)
  }
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "segueToBooks") {
      let dvc = (segue.destinationViewController as! BooksViewController)

      if (selectedList != nil) {
        dvc.dataSource = BooksTableDataSource(list: selectedList!)
      } else {
        dvc.dataSource = BooksTableDataSource()
      }
      dvc.tableView.dataSource = dvc.dataSource
    }
  }
  
  override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
    let canMove = dataSource.tableView(tableView, canMoveRowAtIndexPath: proposedDestinationIndexPath)
    
    if (canMove) {
      return proposedDestinationIndexPath
    } else {
      return sourceIndexPath
    }
  }
}