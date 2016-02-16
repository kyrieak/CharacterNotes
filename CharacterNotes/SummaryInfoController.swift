//
//  SummaryInfoController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/15/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SummaryInfoController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var character: CNCharacter
  var displayRowIDs: [String] = []
  
  required init?(coder aDecoder: NSCoder) {
    character = CNCharacter(context: SummaryInfoController.getDocumentContext())
    character.firstName = "Elizabeth"
    character.lastName  = "Bennet"
    character.ageRangeMin = 18
    character.ageRangeMax = 22
    character.ageRangeIsEstimate = true
    character.yearRangeMin = 1880
    character.yearRangeMax = 1900
    character.yearRangeIsEstimate = true
//    character.pronoun = Pronoun.She.rawValue

    if (character.fullName != "") {
      displayRowIDs.append("nameRow")
    }

    if (character.pronoun != nil) {
      displayRowIDs.append("pronounRow")
    }
    
    if (!character.depictedAge.noInfo) {
      displayRowIDs.append("ageRow")
    }
    
    if (!character.timePeriod.noInfo) {
      displayRowIDs.append("yearRow")
    }
    
    super.init(coder: aDecoder)
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayRowIDs.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let reuseID = displayRowIDs[indexPath.row]
    
    return tableView.dequeueReusableCellWithIdentifier(reuseID)!
  }
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    if (cell.reuseIdentifier == "yearRow") {
      let label = (cell.viewWithTag(2) as! UILabel)
      let tp = character.timePeriod
      
      if (tp.noInfo) {
        Log.withSpace("here in noInfo")
        // should delegate to book info
        label.text = "1690 - 1700"
      } else if (tp.isRanged) {
        Log.withSpace("here in is ranged")
        label.text = "\(tp.min!) - \(tp.max!)"
      } else {
        Log.withSpace("here in not ranged")
        label.text = "\(tp.min!)"
      }
    }
  }
  
  private class func getDocumentContext() -> NSManagedObjectContext {
    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    return delegate.getDocumentContext()
  }

}