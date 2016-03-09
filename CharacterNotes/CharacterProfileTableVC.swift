//
//  TestViewController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/10/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class CharacterProfileVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var character: CNCharacter?
  var displayRowIDs: [String] = []
//  override func viewDidLoad() {
//    let textView = view.viewWithTag(1) as! MarqueeTextView
//    textView.setMarqueeTextTo("Eliza Bennet ")
//  }
  
  required init?(coder aDecoder: NSCoder) {
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).getDocumentContext()
    character = CNCharacter(context: context)
    character?.firstName = "Elizabeth"
    character?.lastName  = "Bennet"
    character?.ageRangeMin = 18
    character?.ageRangeMax = 22
    character?.ageRangeIsEstimate = true
    character?.yearRangeMin = 1880
    character?.yearRangeMax = 1900
    character?.yearRangeIsEstimate = false
    
    if (character?.getFullName() != "") {
      displayRowIDs.append("nameRow")
    }
    
    if (!character!.getAgeRange().noInfo) {
      displayRowIDs.append("ageRow")
    }
    
    if (!character!.getTimePeriod().noInfo) {
      displayRowIDs.append("yearRow")
    }
    
    super.init(coder: aDecoder)
  }
  override func viewDidLoad() {
//    self.automaticallyAdjustsScrollViewInsets = false
  }
  
  override func viewDidLayoutSubviews() {
    let textView = view.viewWithTag(1) as! MarqueeTextView
//    let tableView = view.viewWithTag(2) as! UITableView
//textView.layer.borderWidth  = 1
//    textView.layer.borderColor = UIColor.blueColor().CGColor
    textView.setMarqueeTextTo("Eliza Bennet ")
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if (section == 0) {
      return displayRowIDs.count
    } else {
      return 8
    }
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if (indexPath.section == 0) {
      return tableView.dequeueReusableCellWithIdentifier(displayRowIDs[indexPath.row])!
    } else {
      return tableView.dequeueReusableCellWithIdentifier("quoteRow")!
    }
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