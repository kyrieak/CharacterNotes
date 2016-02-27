//
//  SearchResultsTableVC.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/24/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsTableVC: UITableViewController {
  override func viewDidLoad() {
//    view.frame.origin.y = 100
//    view.frame.size.height -= 100
  }
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCellWithIdentifier("searchResultRow")!
  }
}