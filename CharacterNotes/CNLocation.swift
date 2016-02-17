//
//  CNLocation.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/16/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class CNLocation: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
}


struct Continent {
  static var Africa       = CLLocationCoordinate2D(latitude: 7.19, longitude: 21.09)
  static var Asia         = CLLocationCoordinate2D(latitude: 46.28, longitude: 86.67)
  static var Australia    = CLLocationCoordinate2D(latitude: -35.31, longitude: 149.12)
  static var Europe       = CLLocationCoordinate2D(latitude: 54.90, longitude: 25.32)
  static var NorthAmerica = CLLocationCoordinate2D(latitude: 48.17, longitude: -100.17)
  static var SouthAmerica = CLLocationCoordinate2D(latitude: -13.00, longitude: -59.40)
}


enum RegionScale: Int {
  case Continent = 0
  case Country   = 1
  case City      = 2
  case Other     = 3
}