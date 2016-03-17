//
//  TimelineTableHeader.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 3/11/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit


class DropdownTableHeader: UITableViewHeaderFooterView {
  private(set) var titleLabel: UILabel?
  private(set) var detailLabel: UILabel?
  private(set) var dropdownButton: UIButton?
  
  var section: Int? {
    didSet(newValue) {
      dropdownButton?.tag = (newValue ?? 0)
    }
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    setupSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupSubviews()
  }
  
  func setupSubviews() {
    titleLabel     = viewWithTag(1) as? UILabel
    detailLabel    = viewWithTag(2) as? UILabel
    dropdownButton = viewWithTag(3) as? UIButton

    titleLabel?.tag = 0
    detailLabel?.tag = 0
    dropdownButton?.tag = 0
  }
  
  func addToggleTarget(target: AnyObject, selector: Selector, section: Int) {
    if (target.respondsToSelector(selector)) {
      dropdownButton?.tag = section
      dropdownButton?.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
    }
  }
}