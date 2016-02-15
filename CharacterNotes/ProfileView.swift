//
//  ProfileView.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/10/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: UITableView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.tableHeaderView = UIView(frame: CGRectZero)
  }
//  
//  func makeRepeatingText(frame: CGRect) {
//    var s = NSString(string: "testing ")
//    
//    s.boundingRectWithSize(frame.size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: <#T##[String : AnyObject]?#>, context: nil)
//  }
//  
//  class func repeatingTextAttributes() {
//    //NSFontAttributeName
//    //NSParagraphStyleAttributeName
//    let font = UIFont.italicSystemFontOfSize(12)
//    let paragStyle = NSMutableParagraphStyle()
//    //paragStyle.lineHeightMultiple
//    //paragStyle.lineBreakMode
//    //paragStyle.lineSpacing
//    paragStyle.lineBreakMode = NSLineBreakMode.ByCharWrapping
//  }
}