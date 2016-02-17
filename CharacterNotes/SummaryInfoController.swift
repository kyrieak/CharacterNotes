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
    character.yearRangeIsEstimate = false

    if (character.getFullName() != "") {
      displayRowIDs.append("nameRow")
    }

    if (!character.getAgeRange().noInfo) {
      displayRowIDs.append("ageRow")
    }

    if (!character.getTimePeriod().noInfo) {
      displayRowIDs.append("yearRow")
    }
    
    if (true) {
      displayRowIDs.append("regionRow")
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
    if (cell.reuseIdentifier != nil) {
      switch(cell.reuseIdentifier!) {
        case "ageRow":
          let label = (cell.viewWithTag(2) as! UILabel)
          let astLabel = (cell.viewWithTag(3))
          let age = character.getAgeRange()
          
          if (age.isRanged) {
            label.text = "\(age.min!) - \(age.max!)"
          } else {
            label.text = "\(age.min!)"
          }
          
          astLabel?.hidden = (!age.isEstimate)
        case "yearRow":
          let label = (cell.viewWithTag(2) as! UILabel)
          let astLabel = (cell.viewWithTag(3))
          let tp = character.getTimePeriod()
          
          if (tp.isRanged) {
            label.text = "\(tp.min!) - \(tp.max!)"
          } else {
            label.text = "\(tp.min!)"
          }
          astLabel?.hidden = (!tp.isEstimate)
        default:
          Log.withSpace("default case cell reuseID")
      }
    }
    if (cell.reuseIdentifier == "yearRow") {
      let label = (cell.viewWithTag(2) as! UILabel)
      let tp = character.getTimePeriod()
      
      if (tp.isRanged) {
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