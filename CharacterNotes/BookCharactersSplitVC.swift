//
//  BookCharactersSplitVC.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 3/3/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class BookCharactersSplitVC: UISplitViewController{
  var book: CNBook? {
    return (parentViewController as? BookTabBarController)?.book
  }
  
  override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
  }
}