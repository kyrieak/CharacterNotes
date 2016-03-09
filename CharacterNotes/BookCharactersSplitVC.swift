//
//  BookCharactersSplitVC.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 3/3/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class BookCharactersSplitVC: UISplitViewController, UISplitViewControllerDelegate {
  var book: CNBook? {
    return (parentViewController as? BookTabBarController)?.book
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.delegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.delegate = self
    self.preferredDisplayMode = .AllVisible
  }
  
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
    return true
  }
}