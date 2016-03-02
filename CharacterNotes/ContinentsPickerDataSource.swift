//
//  ContinentsDataSource.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/24/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class ContinentsPickerDataSource: NSObject, UIPickerViewDataSource {
  let worldContinents = Continent.all

  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return worldContinents.count
  }
  
  func continentForRow(row: Int) -> Continent {
    return worldContinents[row]
  }
}