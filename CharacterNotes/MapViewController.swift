//
//  MapViewController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/23/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, UIPickerViewDelegate {
  
  @IBOutlet var pickerDataSource: ContinentsPickerDataSource!
  
  var mapView: MKMapView?
  var pickerView: UIPickerView?
  
  
  
  private var continentSelection: ContinentInfo?
  var searchController: UISearchController?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    searchController = UISearchController(searchResultsController: self)
  }
  
  
  override func viewDidLayoutSubviews() {
    view.addSubview((searchController?.searchBar)!)
    mapView = view.viewWithTag(2) as? MKMapView
    pickerView = view.viewWithTag(4) as? UIPickerView
    
    mapView?.centerCoordinate = CLLocationCoordinate2D(direction: .NW, latitude: 54.5970, longitude: -5.9300)
    
    let poi = PointOfInterest(title: "Belfast, Ireland", coordinates: mapView!.centerCoordinate)

    poi.subtitle = "C.S. Lewis Birthplace"
    mapView?.addAnnotation(poi)
  }
  
  @IBAction func toggleContinentsPicker(sender: UIButton) {
    if ((continentSelection != nil) && (sender.tag == 31)) {
      mapView?.centerCoordinate = continentSelection!.coordinate
      continentSelection = nil
    }
    
    pickerView!.hidden = !pickerView!.hidden
    view.viewWithTag(31)?.hidden = pickerView!.hidden    
  }
  
  // MARK: - Picker Delegate -

  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerDataSource.continentForRow(row).name
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    continentSelection = ContinentInfo.worldContinents[row]
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

extension CLLocationCoordinate2D {
  init(direction: Compass, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
    if (CLLocationCoordinate2D.latitudeSignIsCorrect(direction, latitude: latitude)) {
      self.latitude = latitude
    } else {
      self.latitude = (latitude * -1.00)
    }
    
    if (CLLocationCoordinate2D.longitudeSignIsCorrect(direction, longitude: longitude)) {
      self.longitude = longitude
    } else {
      self.longitude = (longitude * -1.00)
    }
  }
  
  static func latitudeSignIsCorrect(direction: Compass, latitude: CLLocationDegrees) -> Bool {
    switch(direction) {
      case .NE, .NW:
        return (latitude >= 0.00)
      default:
        return (latitude < 0.00)
    }
  }

  static func longitudeSignIsCorrect(direction: Compass, longitude: CLLocationDegrees) -> Bool {
    switch(direction) {
      case .NE, .SE:
        return (longitude >= 0.00)
      default:
        return (longitude < 0.00)
    }
  }
}

enum Compass {
  case NE, NW, SE, SW
}