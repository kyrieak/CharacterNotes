//
//  LinkOpeningVC.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/18/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class LinkOpeningVC: UIViewController {
  required init?(coder aDecoder: NSCoder) {
    UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12, weight: UIFontWeightRegular)], forState: .Normal)
    UITabBar.appearance().tintColor = UIColor(red: 0.68, green: 0.53, blue: 0.44, alpha: 1.0)
    super.init(coder: aDecoder)
  }
  @IBAction func openLink(sender: UIButton) {
    
    UIApplication.sharedApplication().openURL(NSURL(string: "http://itunes.apple.com/us/book/mysterious-affair-at-styles/id765104888?mt=11")!)
  }
}