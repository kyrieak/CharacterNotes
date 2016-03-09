//
//  BookTabViewController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 3/3/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class BookTabBarController: UITabBarController, UITabBarControllerDelegate {
  var book: CNBook?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    delegate = self
    
    UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12, weight: UIFontWeightRegular)], forState: .Normal)
    UITabBar.appearance().tintColor = UIColor(red: 0.68, green: 0.53, blue: 0.44, alpha: 1.0)
    UITabBar.appearance().translucent = false
    UINavigationBar.appearance().translucent = false
  }
}