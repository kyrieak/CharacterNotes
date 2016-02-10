//
//  NavController.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 1/25/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NavController: UINavigationController, UINavigationControllerDelegate {
  typealias Book = CNBook
  typealias List = CNList
  
  var gr: Goodreads
  
  required init?(coder aDecoder: NSCoder) {
//    NavController.seed()

    gr = Goodreads(userID: 51961635, saveContext: NavController.getDocumentContext())
    
    super.init(coder: aDecoder)
    delegate = self

//    gr.session.dataTaskWithRequest(gr.getUserBooksRequest(), completionHandler: {(data: NSData?, resp: NSURLResponse?, error: NSError?) -> Void in
//      Log.withSpace("\(resp)")
//      Log.withSpace("\(error)")
//      let parser = NSXMLParser(data: data!)
//      parser.delegate = self.gr
//      parser.parse()
//    }).resume()
  }
  
  
  class func seed() {
    let context = getDocumentContext()
    let lists = seedLists(context)
    let books = seedBooks(context)
    // 4, 8, 3
    // 2, 8, 7
    // 6, 3, 4
    lists[0].addBooks([books[0], books[1], books[2]])
    lists[1].addBooks([books[4], books[1], books[8]])
    lists[2].addBooks([books[6], books[2], books[0]])
  }
  
  class func seedLists(context: NSManagedObjectContext) -> [List] {
    return [List(order: 1, context: context),
            List(order: 2, context: context),
            List(order: 3, context: context)]
  }
  
  class func seedBooks(context: NSManagedObjectContext) -> [Book] {
    var books: [Book] = []
    let bookOrder = [4, 8, 3, 1, 2, 9, 6, 5, 7]

    for num in bookOrder {
      books.append(Book(order: num, context: context))
    }
    
    return books
  }
  
  private class func getDocumentContext() -> NSManagedObjectContext {
    let delegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    return delegate.getDocumentContext()
  }
  
  func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
    Log.withLine("*", msg: "\(viewController)")
    
    NSNotificationCenter.defaultCenter().addObserver(viewController, selector: Selector("goodReadsParseDone:"), name: "goodReadsParseDone", object: nil)
  }
  
  
//  func goodReadsParseDone(notification: NSNotification) {
//    Log.withLine("=", msg: "did receive notif goodReadsParseDone")
//    Log.withSpace("\(presentedViewController)")
//    if (presentedViewController is BookListViewController) {
//      Log.withSpace("presentedVC is a BookListViewController")
//      let vc = (presentedViewController as! BookListViewController)
//
//      vc.dataSource.fetchController.fetchLists()
//      vc.tableView.reloadData()
//    }
//  }
  
}