//
//  ContinentsDataSource.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/23/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import MapKit

struct ContinentInfo {
  let name: String
  let coordinate: CLLocationCoordinate2D
  
  init(continent: Continent) {
    switch(continent) {
      case .Africa:
        name = "Africa"
        coordinate = CLLocationCoordinate2D(latitude: 7.19, longitude: 21.09)
      case .Antarctica:
        name = "Antarctica"
        coordinate = CLLocationCoordinate2D(latitude: -90.00, longitude: 0.00)
      case .Asia:
        name = "Asia"
        coordinate = CLLocationCoordinate2D(latitude: 46.28, longitude: 86.67)
      case .Australia:
        name = "Australia"
        coordinate = CLLocationCoordinate2D(latitude: -35.31, longitude: 149.12)
      case .Europe:
        name = "Europe"
        coordinate = CLLocationCoordinate2D(latitude: 54.90, longitude: 25.32)
      case .NorthAmerica:
        name = "North America"
        coordinate = CLLocationCoordinate2D(latitude: 48.17, longitude: -100.17)
      case .SouthAmerica:
        name = "South America"
        coordinate = CLLocationCoordinate2D(latitude: -13.00, longitude: -59.40)
    }
  }
  
  static var Africa       = ContinentInfo(continent: .Africa)
  static var Antarctica   = ContinentInfo(continent: .Antarctica)
  static var Asia         = ContinentInfo(continent: .Asia)
  static var Australia    = ContinentInfo(continent: .Australia)
  static var Europe       = ContinentInfo(continent: .Europe)
  static var NorthAmerica = ContinentInfo(continent: .NorthAmerica)
  static var SouthAmerica = ContinentInfo(continent: .SouthAmerica)
  
  static var worldContinents: [ContinentInfo] = [.Africa, .Antarctica, .Asia, .Australia, .Europe, .NorthAmerica, .SouthAmerica]
}


enum Continent {
  case Africa, Antarctica, Asia, Australia, Europe, NorthAmerica, SouthAmerica
}

enum RegionScale: Int {
  case Continent = 0
  case Country   = 1
  case City      = 2
  case Other     = 3
}