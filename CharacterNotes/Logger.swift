//
//  File.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation

struct Log {
  static func withLine(char: Character, msg: String) {
    let line = String(count: 48, repeatedValue: char)

    NSLog("\(line)\n\n\(msg)\n\n\(line)")
  }
  
  static func withSpace(msg: String) {
    NSLog("\n\n\(msg)\n\n")
  }
}