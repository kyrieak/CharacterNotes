//
//  ContinentsDataSource.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/23/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import MapKit


enum Continent: String {
  case Africa, Antarctica, Asia, Australia, Europe, NorthAmerica, Oceania, SouthAmerica
  
  static var all: [Continent] = [.Africa, .Antarctica, .Asia, .Australia,
                                 .Europe, .NorthAmerica, .Oceania, .SouthAmerica]
}


extension MKCoordinateRegion {
  static func forContinent(continent: Continent) -> MKCoordinateRegion {
    return MKCoordinateRegion(center: CLLocationCoordinate2D.centerPointFor(continent),
                                span: MKCoordinateSpan.forContinent(continent))
  }
  
}


extension MKCoordinateSpan {
  static func forContinent(continent: Continent) -> MKCoordinateSpan {
    let latitRange  = Latitude.rangeFor(continent)
    let (wBound, eBound) = Longitude.rangeFor(continent)

    let latitDelta  = abs(latitRange.min.degrees - latitRange.max.degrees)
    var longitDelta = abs(wBound.degrees - eBound.degrees)

    var passes180: Bool
    
    if (wBound.direction == eBound.direction) {
      if (wBound.direction == .W) {
        passes180 = (abs(wBound.degrees) < abs(eBound.degrees))
      } else {
        passes180 = (abs(wBound.degrees) > abs(eBound.degrees))
      }
    } else {
      passes180 = (wBound.direction == .E)
    }

    if (passes180) {
      longitDelta = 360 - longitDelta
    }
    Log.withSpace("\(continent), longitDelta: \(longitDelta)\nlatitDelta\(latitDelta)")

    return MKCoordinateSpan(latitudeDelta: latitDelta, longitudeDelta: longitDelta)
  }
}

extension CLLocationCoordinate2D {
  init(latitude: Latitude, longitude: Longitude) {
    self.latitude = latitude.degrees
    self.longitude = longitude.degrees
  }
  
  static func centerPointFor(continent: Continent) -> CLLocationCoordinate2D {
    let latitRange  = Latitude.rangeFor(continent)
    let (wBound, eBound) = Longitude.rangeFor(continent)
    
    let latitAvg  = ((latitRange.min.degrees + latitRange.max.degrees) / 2.00)
    let longitAvg = Longitude.midLine(wBound, eastBound: eBound).degrees
    
    Log.withSpace("\(continent) center is: \n (\(latitAvg)NS, \(longitAvg)EW)")
    return CLLocationCoordinate2D(latitude: latitAvg, longitude: longitAvg)
  }
}

extension MKPointAnnotation {
  convenience init(title: String, coordinates: CLLocationCoordinate2D) {
    self.init()
    
    self.title = title
    self.coordinate = coordinates
  }
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


struct Latitude {
  private var degrees: CLLocationDegrees
  private var direction: Latitude.Dir
  
  enum Dir {
    case N, S
  }
  
  init(deg: CLLocationDegrees, dir: Latitude.Dir) {
    self.degrees   = deg
    self.direction = dir
    
    Latitude.matchSignToDirection(&degrees, dir: &direction)
  }
  
  static func matchSignToDirection(inout deg: Double, inout dir: Latitude.Dir) {
    switch(dir) {
      case .N:
        if (deg < 0.00) {
          deg = abs(deg)
        }
      case .S:
        if (deg > 0.00) {
          deg *= -1.00
        }
    }
  }
  
  static func adjustValuesTo90Range(inout deg: Double, inout dir: Latitude.Dir) {
    if (abs(deg) > 90.00) {
      let deltaPole = ((deg > 0) ? -180.00 : 180.00)
      
      while (abs(deg) > 90) {
        deg += deltaPole
        dir = ((dir == .N) ? .S : .N)
      }
    }
  }

  
  static func rangeFor(continent: Continent) -> (min: Latitude, max: Latitude) {
    switch(continent) {
      case .Africa:
        return (min: Latitude(deg: 38.00, dir: .N), max: Latitude(deg: -35.00, dir: .S))
      case .Antarctica:
        return (min: Latitude(deg: -60.00, dir: .S), max: Latitude(deg: -90.00, dir: .S))
      case .Asia:
        return (min: Latitude(deg: 82.00, dir: .N), max: Latitude(deg: -11.00, dir: .S))
      case .Australia:
        return (min: Latitude(deg: -9.00, dir: .S), max: Latitude(deg: -44.00, dir: .S))
      case .Europe:
        return (min: Latitude(deg: 82.00, dir: .N), max: Latitude(deg: 27.00, dir: .N))
      case .NorthAmerica:
        return (min: Latitude(deg: 84.00, dir: .N), max: Latitude(deg: 5.00, dir: .N))
      case .Oceania:
        return (min: Latitude(deg: 29.00, dir: .N), max: Latitude(deg: -53.00, dir: .S))
      case .SouthAmerica:
        return (min: Latitude(deg: 14.00, dir: .N), max: Latitude(deg: -60.00, dir: .S))
    }
  }
}

struct Longitude {
  private var degrees: CLLocationDegrees
  private var direction: Longitude.Dir
  
  enum Dir {
    case E, W
  }
  
  init(deg: CLLocationDegrees, dir: Longitude.Dir) {
    degrees   = deg
    direction = dir
    
    Longitude.matchSignToDirection(&degrees, dir: &direction)
    Longitude.adjustValuesTo180Range(&degrees, dir: &direction)
  }

  
  static func matchSignToDirection(inout deg: Double, inout dir: Longitude.Dir) {
    switch(dir) {
      case .E:
        if (deg < 0.00) {
          deg = abs(deg)
        }
      case .W:
        if (deg > 0.00) {
          deg *= -1.00
        }
    }
  }
  
  static func adjustValuesTo180Range(inout deg: Double, inout dir: Longitude.Dir) {
    if (abs(deg) > 180.00) {
      while (abs(deg) > 180) {
        deg = 360.00 - abs(deg)
        dir = ((dir == .E) ? .W : .E)
      }
    }
  }
  
  static func rangeFor(continent: Continent) -> (wBound: Longitude, eBound: Longitude) {
    switch(continent) {
      case .Africa:
        return (wBound: Longitude(deg: -26.00, dir: .W), eBound: Longitude(deg: 64.00, dir: .E))
      case .Antarctica:
        return (wBound: Longitude(deg: -180.00, dir: .W), eBound: Longitude(deg: 180.00, dir: .E))
      case .Asia:
        return (wBound: Longitude(deg: 27.00, dir: .E), eBound: Longitude(deg: -170.00, dir: .W))
      case .Australia:
        return (wBound: Longitude(deg: 72.00, dir: .E), eBound: Longitude(deg: 168.00, dir: .E))
      case .Europe:
        return (wBound: Longitude(deg: -32.00, dir: .W), eBound: Longitude(deg: 70.00, dir: .E))
      case .NorthAmerica:
        return (wBound: Longitude(deg: -11.00, dir: .W), eBound: Longitude(deg: -180.00, dir: .W))
      case .Oceania:
        return (wBound: Longitude(deg: 113.00, dir: .E), eBound: Longitude(deg: -109.00, dir: .W))
      case .SouthAmerica:
        return (wBound: Longitude(deg: -110.00, dir: .W), eBound: Longitude(deg: -26.00, dir: .W))
    }
  }
  
  static func midLine(westBound: Longitude, eastBound: Longitude) -> Longitude {
    var passes180: Bool
    var degrees: CLLocationDegrees

    
    if (westBound.direction == eastBound.direction) {
      if (westBound.direction == .W) {
        passes180 = (abs(westBound.degrees) < abs(eastBound.degrees))
      } else {
        passes180 = (abs(westBound.degrees) > abs(eastBound.degrees))
      }
    } else {
      passes180 = (westBound.direction == .E)
    }
    
    if (passes180) {
      let span = 360.00 - abs(westBound.degrees - eastBound.degrees)

      if (westBound.direction == .E) {
        degrees = westBound.degrees + (span / 2.00)
      } else {
        degrees = westBound.degrees - (span / 2.00)
      }
      
      return Longitude(deg: degrees, dir: westBound.direction)
    } else {
      degrees = ((westBound.degrees + eastBound.degrees) / 2.00)
      
      return Longitude(deg: degrees, dir: ((degrees > 0.00) ? .E : .W))
    }
  }
}