//
//  LinkOpeningVC.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/18/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class BookInfoVC: UIViewController {
  var book: CNBook? {
    return (parentViewController as? BookTabBarController)?.book
  }
  
  override func viewDidLoad() {
    Log.withSpace("bookInfoVC viewDidLoad")
  }
  
  @IBAction func openLink(sender: UIButton) {
    UIApplication.sharedApplication().openURL(NSURL(string: "http://itunes.apple.com/us/book/mysterious-affair-at-styles/id765104888?mt=11")!)
  }
  
  @IBAction func editAction(sender: UIBarButtonItem) {
  }
}