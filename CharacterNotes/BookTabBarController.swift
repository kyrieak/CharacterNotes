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
  
  lazy var editBookInfoButton: UIBarButtonItem = {
    return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self.viewControllers![0], action: Selector("editAction:"))
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    delegate = self
    
    UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(12, weight: UIFontWeightRegular)], forState: .Normal)
    UITabBar.appearance().tintColor = UIColor(red: 0.68, green: 0.53, blue: 0.44, alpha: 1.0)
  }
  
  
  override func viewDidLoad() {
    Log.withSpace("BookTabBarController viewDidLoad")

    navigationItem.title = (book?.title ?? "")
    navigationItem.rightBarButtonItem = editBookInfoButton
  }
  
  override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
    Log.withSpace("\(viewControllers?.description)")
    super.tabBar(tabBar, didSelectItem: item)

    if (item.title != "Book Info") {
      navigationItem.rightBarButtonItem = nil
    } else {
      navigationItem.rightBarButtonItem = editBookInfoButton
    }
  }
}