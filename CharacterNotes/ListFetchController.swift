//
//  ListFetchController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ListFetchController: NSFetchedResultsController {
  typealias ListFC   = ListFetchController
  typealias SortDesc = NSSortDescriptor

  private var documentContext: NSManagedObjectContext

  override init() {
    documentContext = ListFC.getDocumentContext()

    super.init(fetchRequest: ListFC.requestAllLists(),
                 managedObjectContext: documentContext,
                   sectionNameKeyPath: nil, cacheName: nil)
    fetchLists()
  }
  
  
  func fetchLists() {
    do {
      try performFetch()
    } catch {
      NSLog("performFetch failed")
    }
  }


  
  class func requestAllLists() -> NSFetchRequest {
    let req = NSFetchRequest(entityName: "CNList")
    
    req.sortDescriptors = [SortDesc(key: "name", asc: true)]
    req.fetchBatchSize  = 20
    
    return req
  }

  
  private class func getDocumentContext() -> NSManagedObjectContext {
    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    return delegate.getDocumentContext()
  }
}