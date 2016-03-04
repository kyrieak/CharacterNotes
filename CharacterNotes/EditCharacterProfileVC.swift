//
//  SummaryViewController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/14/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class EditCharacterProfileVC: UIViewController, UITextFieldDelegate {
  var textFields: [UITextField] = []
  //var isEditing = false
  
  override func viewDidLayoutSubviews() {
    if (textFields.count < 1) {
      editing = false
      
      textFields.append((view.viewWithTag(11) as! UITextField))
      textFields.append((view.viewWithTag(12) as! UITextField))
      textFields.append((view.viewWithTag(13) as! UITextField))
      textFields.append((view.viewWithTag(22) as! UITextField))
      
      let borderStyle: UITextBorderStyle = (editing ? .RoundedRect : .None)
      
      for tf in textFields {
        tf.enabled = editing
        tf.borderStyle = borderStyle
      }
    }
  }
  
  
  @IBAction func didTapEditOrDone(sender: UIBarButtonItem) {
    editing = !editing
    Log.withLine("#", msg: "!editing? \(!editing)")
    
    let borderStyle: UITextBorderStyle = (editing ? .RoundedRect : .None)
    
    for tf in textFields {
      tf.enabled = editing
      tf.borderStyle = borderStyle

      if (!editing && (tf.text == "")) {
        tf.hidden = true
      } else {
        tf.hidden = false
      }
    }
Log.withLine("#", msg: "editing? \(editing)")
    sender.title = (editing ? "Done" : "Edit")
  }
}