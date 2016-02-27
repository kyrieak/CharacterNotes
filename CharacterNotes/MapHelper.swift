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


class PointOfInterest: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  
  init(title: String, coordinates: CLLocationCoordinate2D) {
    self.title = title
    self.coordinate = coordinates
  }
}

extension CLLocationCoordinate2D {
//  init(direction: Compass, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//    self.latitude = Latitude.signedDegrees(<#T##degrees: Double##Double#>, dir: <#T##LatitudeDir#>)
//    if (CLLocationCoordinate2D.latitudeSignIsCorrect(direction, latitude: latitude)) {
//      self.latitude = latitude
//    } else {
//      self.latitude = (latitude * -1.00)
//    }
//    
//    if (CLLocationCoordinate2D.longitudeSignIsCorrect(direction, longitude: longitude)) {
//      self.longitude = longitude
//    } else {
//      self.longitude = (longitude * -1.00)
//    }
//  }
//  
  init(latitude: Latitude, longitude: Longitude) {
    self.latitude = latitude.degrees
    self.longitude = longitude.degrees
  }
//  
//  static func latitudeSignIsCorrect(direction: Compass, latitude: CLLocationDegrees) -> Bool {
//    switch(direction) {
//    case .NE, .NW:
//      return (latitude >= 0.00)
//    default:
//      return (latitude < 0.00)
//    }
//  }
//  
//  static func longitudeSignIsCorrect(direction: Compass, longitude: CLLocationDegrees) -> Bool {
//    switch(direction) {
//    case .NE, .SE:
//      return (longitude >= 0.00)
//    default:
//      return (longitude < 0.00)
//    }
//  }
}

enum Compass {
  case NE, NW, SE, SW
}

enum LatitudeDir {
  case N, S
}

enum LongitudeDir {
  case E, W
}

struct Latitude {
  private var degrees: CLLocationDegrees
  private var direction: LatitudeDir
  
  init(deg: CLLocationDegrees, dir: LatitudeDir) {
    self.degrees   = Latitude.signedDegrees(deg, dir: dir)
    self.direction = dir
  }
  
  static func signedDegrees(degrees: Double, dir: LatitudeDir) -> CLLocationDegrees {
    switch(dir) {
      case .N:
        return ((degrees < 0.00) ? abs(degrees) : degrees)
      case .S:
        return ((degrees > 0.00) ? (degrees * -1.00) : degrees)
    }
  }
}

struct Longitude {
  private var degrees: CLLocationDegrees
  private var direction: LongitudeDir
  
  init(deg: CLLocationDegrees, dir: LongitudeDir) {
    self.degrees   = Longitude.signedDegrees(deg, dir: dir)
    self.direction = dir
  }

  static func signedDegrees(degrees: Double, dir: LongitudeDir) -> CLLocationDegrees {
    switch(dir) {
      case .E:
        return ((degrees < 0.00) ? abs(degrees) : degrees)
      case .W:
        return ((degrees > 0.00) ? (degrees * -1.00) : degrees)
    }
  }
}