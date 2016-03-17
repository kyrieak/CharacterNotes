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
  
  
  @IBAction func toggleSection(sender: UIButton) {
//    let section = sender.tag
//    let tableView = (view.viewWithTag(20) as! UITableView)
    let contentHeight = view.bounds.height - 40 - 64

    let timelineSection = view.viewWithTag(1)!
    let placesSection = view.viewWithTag(2)!

    Log.withSpace("dropdown tag is: \(sender.tag)")
    
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
        
        placesSection.frame.origin.y = timelineSection.frame.maxY
        
        }, completion: {(complete: Bool) in
          self.timelineTableOpen = !self.timelineTableOpen
          self.placesTableOpen = false
      })
      timelineSection.viewWithTag(11)!.setNeedsDisplay()

    } else {
      UIView.animateWithDuration(0.5, animations: {
        if (self.timelineTableOpen) {
          timelineSection.frame.size.height = 32
        }

        placesSection.frame.origin.y = timelineSection.frame.maxY
        
        if (self.placesTableOpen) {
          placesSection.frame.size.height = 32
        } else {
          placesSection.frame.size.height = contentHeight
        }

        }, completion: {(complete: Bool) in
          self.placesTableOpen = !self.placesTableOpen
          self.timelineTableOpen = false
      })
    }
    

//    stackView.frame.size.height = contentHeight + 64
    
//    UIView.animateWithDuration(1.0, animations: {
//      timelineTable.frame.size.height = newFrame.height
//      }, completion: {(complete: Bool) -> Void in
//      Log.withSpace("complete? \(complete) \nheight: \(timelineTable.frame.height)")
//        Log.withSpace("complete? \(complete) \nheight: \(self.view.viewWithTag(123)!.frame.height)")
//    })

    //    if (activeSection == nil) {
//      activeSection = section
//
//      UIView.animateWithDuration(1.0, animations: {
//        self.view.viewWithTag(self.tag.timelineTable)!.bounds.size.height = stackView.frame.height - 64
//      })
//      tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Top)
//    } else {
//      let aSection = activeSection!
//      
//      activeSection = nil
//      
//      tableView.reloadSections(NSIndexSet(index: aSection), withRowAnimation: .Fade)
//
//      if (aSection != sender.tag) {
//        activeSection = sender.tag
//        
//        tableView.reloadSections(NSIndexSet(index: activeSection!), withRowAnimation: .Fade)
//      }
//    }
  }
}