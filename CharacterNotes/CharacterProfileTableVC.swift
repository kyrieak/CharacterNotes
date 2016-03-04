//
//  TestViewController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/10/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class CharacterProfileTableVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
//  override func viewDidLoad() {
//    let textView = view.viewWithTag(1) as! MarqueeTextView
//    textView.setMarqueeTextTo("Eliza Bennet ")
//  }
  override func viewDidLoad() {
    self.automaticallyAdjustsScrollViewInsets = false
  }
  
  override func viewDidLayoutSubviews() {
    let textView = view.viewWithTag(1) as! MarqueeTextView
//    let tableView = view.viewWithTag(2) as! UITableView
//textView.layer.borderWidth  = 1
//    textView.layer.borderColor = UIColor.blueColor().CGColor
    textView.setMarqueeTextTo("Eliza Bennet ")
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 3
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let quoteRow = tableView.dequeueReusableCellWithIdentifier("quoteRow")
    
    return quoteRow!
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch(section) {
    case 0:
      return "First Impressions"
    case 1:
      return "World Outlook"
    default:
      return "Past Memories"
    }
  }
  
//  
//  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let header = tableView.dequeueReusableCellWithIdentifier("sectionHeaderRow")
//    Log.withSpace("?? \(header!.subviews)")
//    let label = header!.contentView.subviews.first as! UILabel
//    
//    switch(section) {
//    case 1:
//      label.text = "General Description"
//    case 2:
//      label.text = "World Outlook"
//    default:
//      label.text = "Fav. Quotes"
//    }
//
//    return header
//  }
}