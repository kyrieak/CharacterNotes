//
//  ContinentsDataSource.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/23/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
  static func forContinent(continent: Continent) -> MKCoordinateRegion {
    return MKCoordinateRegion(center: CLLocationCoordinate2D.centerPointFor(continent),
                                span: MKCoordinateSpan.forContinent(continent))
  }
}


extension MKCoordinateSpan {
  static func forContinent(continent: Continent) -> MKCoordinateSpan {
    let latitRange = Latitude.rangeFor(continent)
    let longitRange = Longitude.rangeFor(continent)
    
    let latitDelta = abs((latitRange.min.degrees - latitRange.max.degrees) / 2.00)
    let longitDelta = abs((longitRange.min.degrees - longitRange.max.degrees) / 2.00)

    return MKCoordinateSpan(latitudeDelta: latitDelta, longitudeDelta: longitDelta)
  }
}

extension CLLocationCoordinate2D {
  init(latitude: Latitude, longitude: Longitude) {
    self.latitude = latitude.degrees
    self.longitude = longitude.degrees
  }
  
  static func centerPointFor(continent: Continent) -> CLLocationCoordinate2D {
    let latitudeRange = Latitude.rangeFor(continent)
    let longitudeRange = Longitude.rangeFor(continent)
    
    let avgLatitude = ((latitudeRange.min.degrees + latitudeRange.max.degrees) / 2.00)
    let avgLongitude = ((longitudeRange.min.degrees + longitudeRange.max.degrees) / 2.00)
    
    return CLLocationCoordinate2D(latitude: avgLatitude, longitude: avgLongitude)
  }
}


enum Continent {
  case Africa, Antarctica, Asia, Australia, Europe, NorthAmerica, SouthAmerica
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
      case .SouthAmerica:
        return (min: Latitude(deg: 14.00, dir: .N), max: Latitude(deg: -60.00, dir: .S))
    }
  }
  
  static func getAvg(l1: Latitude, l2: Latitude) -> Latitude {
    let avgDeg = ((l1.degrees + l2.degrees) / 2.00)
    let avgDir: LatitudeDir = ((avgDeg > 0) ? .N : .S)
    
    return Latitude(deg: avgDeg, dir: avgDir)
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
  
  static func rangeFor(continent: Continent) -> (min: Longitude, max: Longitude) {
    switch(continent) {
      case .Africa:
        return (min: Longitude(deg: 64.00, dir: .E), max: Longitude(deg: -26.00, dir: .W))
      case .Antarctica:
        return (min: Longitude(deg: 180.00, dir: .E), max: Longitude(deg: -180.00, dir: .W))
      case .Asia:
        return (min: Longitude(deg: -170.00, dir: .W), max: Longitude(deg: 27.00, dir: .E))
      case .Australia:
        return (min: Longitude(deg: 168.00, dir: .E), max: Longitude(deg: 72.00, dir: .E))
      case .Europe:
        return (min: Longitude(deg: 70.00, dir: .E), max: Longitude(deg: -32.00, dir: .W))
      case .NorthAmerica:
        return (min: Longitude(deg: -11.00, dir: .W), max: Longitude(deg: -53.00, dir: .W))
      case .SouthAmerica:
        return (min: Longitude(deg: -26.00, dir: .W), max: Longitude(deg: -110.00, dir: .W))
    }
  }
}