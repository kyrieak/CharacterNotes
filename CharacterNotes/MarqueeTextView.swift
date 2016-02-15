//
//  MarqueeTextView.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/10/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class MarqueeTextView: UITextView {
  let paragStyle = MarqueeTextView.paragraphStyle()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setDefaults()
  }
  
  func setDefaults() {
    self.textContainerInset = UIEdgeInsetsMake(-6, -6, -6, -6)
    self.font          = UIFont(name: "Baskerville-Italic", size: 24)
    self.textColor     = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    self.editable      = false
//    self.scrollEnabled = false
    self.selectable = false
    self.userInteractionEnabled = false
  }
  
  
  func setMarqueeTextTo(str: String) {
//    scrollEnabled = true

    let textAttrs = textAttributes()
    let strSize    = calculateStringSize(str, attrs: textAttrs)
    let multiplier = calculateStringMultiplier(strSize)
    
    self.attributedText = NSAttributedString(string: makeRepeatingString(str, multiplier: multiplier),
                                               attributes: textAttrs)
    self.contentOffset = CGPointZero
    
//    scrollEnabled = false
  }
  
  private func calculateStringSize(str: String, attrs: [String: AnyObject]) -> CGSize {
    return str.boundingRectWithSize(frame.size,
                                      options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                        attributes: attrs, context: nil).size
  }
  
  private func calculateStringMultiplier(strSize: CGSize) -> Int {
    let wFactor = Int(ceil(frame.size.width / strSize.width))
    Log.withSpace("\(frame.size) and \(strSize)")
    let hFactor = Int(ceil(frame.size.height / strSize.height))
    
    return wFactor * hFactor
  }
  
  private func makeRepeatingString(str: String, multiplier: Int) -> String {
    let len = str.characters.count * multiplier
    Log.withLine("-", msg: "str: \(str), multiplier: \(multiplier)")
    return str.stringByPaddingToLength(len, withString: str, startingAtIndex: 0)
  }
  
  private func textAttributes() -> [String: AnyObject] {
    var attrs = [String: AnyObject]()
    
    attrs[NSFontAttributeName]            = self.font
    attrs[NSForegroundColorAttributeName] = self.textColor
    attrs[NSParagraphStyleAttributeName]  = self.paragStyle

    return attrs
  }
  
  class func paragraphStyle() -> NSMutableParagraphStyle {
    let paragStyle = NSMutableParagraphStyle()
    paragStyle.lineBreakMode = NSLineBreakMode.ByCharWrapping
    //paragStyle.lineHeightMultiple
    //paragStyle.lineSpacing

    return paragStyle
  }
}