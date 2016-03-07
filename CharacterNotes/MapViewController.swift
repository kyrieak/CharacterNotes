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

class MapViewController: UIViewController, UIPickerViewDelegate, MKMapViewDelegate {
  // MARK: - Properties -
  var book: CNBook?
  
  // MARK: Objects
  
  @IBOutlet var pickerDataSource: ContinentsPickerDataSource!
  private(set) var searchController: UISearchController?
  
  // MARK: Subviews
  
  private var navBar: UINavigationBar?
  private var mapView: MKMapView?
  private var pickerView: UIPickerView?
  private var goBtn: UIButton?
  
  // MARK: State
  
  private var setupDone = false
  private var continentSelection: Continent?
  
  

  /* -------------------------------------------------------------- */
  
  // MARK: - Initializer -

  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("searchResultsTableVC")
    
    searchController = UISearchController(searchResultsController: vc)
  }

  
  /* -------------------------------------------------------------- */
  
  // MARK: - Controller -
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navBar = navigationController!.navigationBar

    setupSearchBar()
  }
  
  
  override func viewDidLayoutSubviews() {
    if (!setupDone) {
      setupSubviewRefs()
      setupMap()
      setupPicker()
      
      setupDone = true
    }
  }
  
  /* -------------------------------------------------------------- */

  // MARK: - Picker Delegate -
  
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerDataSource.continentForRow(row).rawValue
  }
  
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    continentSelection = pickerDataSource.continentForRow(row)
  }

  
  /* -------------------------------------------------------------- */
  
//  // MARK: - MapView Delegate -
//
//  func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
//    mapView.region = nil
//  }
//  
  /* -------------------------------------------------------------- */

  // MARK: - IBAction -
  
  
  @IBAction func toggleContinentsPicker(sender: UIButton) {
    if ((continentSelection != nil) && (sender.tag == goBtn?.tag)) {
      mapView?.setRegion(MKCoordinateRegion.forContinent(continentSelection!), animated: false)
      continentSelection = nil
    }
    
    pickerView!.hidden = !pickerView!.hidden
    goBtn?.hidden = pickerView!.hidden
  }
  
  
  /* -------------------------------------------------------------- */
  
  // MARK: - private -
  
  
  private func setupSearchBar() {
    searchController!.searchBar.frame.origin = CGPoint(x: navBar!.frame.minX, y: navBar!.frame.maxY)
    searchController!.view.frame.origin.y = navBar!.frame.maxY + 44
    navigationController!.view.addSubview((searchController?.searchBar)!)
    
//    view.addSubview(searchController!.searchBar)
//
    searchController?.dimsBackgroundDuringPresentation = false
    searchController?.hidesNavigationBarDuringPresentation = false
//    searchController?.definesPresentationContext = true

//    searchController!.searchBar.frame.origin = origin
//    var navItem = UINavigationItem()
//    navItem.titleView = searchController!.searchBar
//    navigationController!.navigationBar.setItems([navItem], animated: false)
//    view.addSubview(searchController!.searchBar)
  }
  
  
  private func setupSubviewRefs() {
    mapView    = view.viewWithTag(2) as? MKMapView
    pickerView = view.viewWithTag(4) as? UIPickerView
    goBtn      = view.viewWithTag(31) as? UIButton
  }
  
  
  private func setupMap() {
    setMapCenter(CLLocationCoordinate2D(latitude: Latitude(deg: 54.5970, dir: .N),
      longitude: Longitude(deg: -5.9300, dir: .W)))
    Log.withSpace("\(mapView?.centerCoordinate)")
    setMapPOI()
  }

  
  private func setMapCenter(coordinate: CLLocationCoordinate2D) {
    mapView?.centerCoordinate = CLLocationCoordinate2D(latitude: Latitude(deg: 54.5970, dir: .N),
      longitude: Longitude(deg: -5.9300, dir: .W))
  }
  
  private func setMapPOI() {
    let poi = MKPointAnnotation(title: "Belfast, Ireland", coordinates: mapView!.centerCoordinate)
    
    poi.subtitle = "C.S. Lewis Birthplace"
    mapView?.addAnnotation(poi)
  }
  
  
  private func setupPicker() {
    pickerView?.selectRow(0, inComponent: 0, animated: false)
    continentSelection = pickerDataSource.continentForRow(0)
  }
}

