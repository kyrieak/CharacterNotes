//
//  LinkOpeningVC.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/18/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class BookInfoVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  let tag: (timelineTable: Int, placesTable: Int) = (11, 21)
  
  var book: CNBook? {
    return (parentViewController as? BookTabBarController)?.book
  }
  
  var timelineTableOpen = false
  var placesTableOpen   = false
  
  private(set) var activeSection: Int?
  
  override func viewDidLoad() {
    Log.withSpace("bookInfoVC viewDidLoad")
//    var textAttributes = (navigationController?.navigationBar.titleTextAttributes ?? [String: AnyObject]())
//    textAttributes[NSFontAttributeName] = UIFont.boldSystemFontOfSize(16)
//    navigationController?.navigationBar.titleTextAttributes = textAttributes
  }
  
  override func viewDidLayoutSubviews() {
    let timelineSection = view.viewWithTag(1)
    let placesSection = view.viewWithTag(2)
    
    timelineSection?.frame.size.height = 32
    placesSection?.frame.size.height = 32
    
    let timelineHeader = timelineSection!.viewWithTag(10)!
    let placesHeader = placesSection!.viewWithTag(20)!
    
    timelineHeader.layer.borderWidth = 1
    placesHeader.layer.borderWidth = 1
    timelineHeader.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).CGColor
    placesHeader.layer.borderColor = timelineHeader.layer.borderColor
//    let timelineTable = view.viewWithTag(tag.timelineTable)!
//    let placesTable = view.viewWithTag(tag.placesTable)!
//    let contentHeight = view.bounds.height - 40 - 64
//    
//    timelineTable.frame.size.height = contentHeight
//    placesTable.frame.size.height = contentHeight
//    view.viewWithTag(1)?.clipsToBounds = true

//
//    timelineTable.hidden = true
//    placesTable.hidden = true
  }
  
  @IBAction func openLink(sender: UIButton) {
    UIApplication.sharedApplication().openURL(NSURL(string: "http://itunes.apple.com/us/book/mysterious-affair-at-styles/id765104888?mt=11")!)
  }
  
  @IBAction func editAction(sender: UIBarButtonItem) {
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch(tableView.tag) {
      case tag.timelineTable:
        return 6
      case tag.placesTable:
        return 8
      default:
        return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let reuseID: String

    switch(tableView.tag) {
      case tag.timelineTable:
        reuseID = "timelineRow"
      default:
        reuseID = "placeRow"
    }
    
    return tableView.dequeueReusableCellWithIdentifier(reuseID)!
  }
  
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    switch(tableView.tag) {
      case tag.timelineTable:
        return 124
      default:
        return 96
    }
  }
  
  
  func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    if (tableView.tag == tag.placesTable) {
      Log.withLine("-", msg: "\(cell.reuseIdentifier)")
    }
  }
  
  @IBAction func toggleSection(sender: UIButton) {
    let contentHeight = view.bounds.height - 40 - 64

    let timelineSection = view.viewWithTag(1)!
    let placesSection = view.viewWithTag(2)!
    
    placesSection.viewWithTag(21)?.frame.size.height = contentHeight
    Log.withLine("T", msg: "\(placesSection.viewWithTag(21)!.frame)")
    Log.withLine("S", msg: "\(placesSection.frame)")

    if (sender.tag == 100) {
      UIView.animateWithDuration(0.5, animations: {
        if (self.placesTableOpen) {
          placesSection.frame.size.height = 32
        }
        
        if (self.timelineTableOpen) {
          timelineSection.frame.size.height = 32
        } else {
          timelineSection.frame.size.height = contentHeight
        }
        
        placesSection.frame.origin.y = timelineSection.frame.maxY - 1
        
        }, completion: {(complete: Bool) in
          self.timelineTableOpen = !self.timelineTableOpen
          self.placesTableOpen = false
      })
    } else {
      UIView.animateWithDuration(0.5, animations: {
        if (self.timelineTableOpen) {
          timelineSection.frame.size.height = 32
        }

        placesSection.frame.origin.y = timelineSection.frame.maxY - 1
        
        if (self.placesTableOpen) {
          placesSection.frame.size.height = 32
        } else {
          placesSection.frame.size.height = contentHeight
        }

        }, completion: {(complete: Bool) in
          self.placesTableOpen = !self.placesTableOpen
          self.timelineTableOpen = false
          placesSection.viewWithTag(21)?.setNeedsDisplay()
      })
    }
  }
}