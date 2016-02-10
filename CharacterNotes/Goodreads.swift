//
//  Goodreads.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Goodreads: NSObject, NSXMLParserDelegate {
  let userID: Int
  let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
  let saveContext: NSManagedObjectContext
//  private var bookInfo = [String: String]()
  private var bookInfo   = GRBook()
  private var authorInfo = GRAuthor()
  private var shelfInfo  = GRShelf()
  private var isParsingBookInfo = false
  private var currentKey: String = ""
  private var currentBook: CNBook?
  private var currentShelves: [CNList] = []
  private var authorName = ""
  
  private var listByShelfID = [Int: CNList]()
  
  init(userID: Int, saveContext: NSManagedObjectContext) {
    self.userID = userID
    self.saveContext = saveContext

    super.init()
  }
  
  
  class func queryItems() -> [NSURLQueryItem] {
    var items: [NSURLQueryItem] = [NSURLQueryItem(name: "id", value: "51961635")]

    items.append(NSURLQueryItem(name: "key", value: "McIWA9UMcPsNntgynxOrw"))
    
    return items
  }
  
  
  func getUserBooksURL() -> NSURL {
    var url = "https://www.goodreads.com/review/list"
    
    url += "/\(userID)?format=xml&key=McIWA9UMcPsNntgynxOrw&v=2"
    
    return NSURL(string: url)!
  }
  
  func getUserBooksRequest() -> NSURLRequest {
    let req = NSURLRequest(URL: getUserBooksURL())

    return req
  }
  
//  class func requestBookFromUserShelf(userID: Int) -> NSURLRequest {
//    return NSURLRequest(URL: NSURL(string: "https://www.goodreads.com/review/list/\(userID)?format=xml&key=McIWA9UMcPsNntgynxOrw&v=2"))
//  }
  
//  class func getBooksFromUserShelfURL(userID: Int) -> String {
//    var baseURL = "https://www.goodreads.com/review/list"
//    
//    baseURL += "/\(userID)?format=xml&key=McIWA9UMcPsNntgynxOrw&v=2"
//    
//    return baseURL
//  }
  
  func dostuff() {
    NSLog("did get here")
    let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())

    session.dataTaskWithURL(getUserBooksURL(), completionHandler: {(data: NSData?, resp: NSURLResponse?, error: NSError?) -> Void in
      Log.withSpace("am i handling?")
      Log.withLine("-", msg: "\(data?.description)")
      Log.withLine("-", msg: "\(resp?.description)")
      Log.withLine("-", msg: "\(error?.description)")
    }).resume()
  }
  
  func handleResponse(data: NSData?, resp: NSURLResponse?, error: NSError?) -> Void {
    Log.withSpace("am i handling?")
    Log.withLine("-", msg: "\(data?.description)")
    Log.withLine("-", msg: "\(resp?.description)")
    Log.withLine("-", msg: "\(error?.description)")
  }
  
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    switch(elementName) {
      case "book":
        isParsingBookInfo = true
      case "shelf":
        if (attributeDict["review_shelf_id"] != nil) {
          shelfInfo.grID = Int(trimWhiteSpace(attributeDict["review_shelf_id"]!))
          shelfInfo.name = trimWhiteSpace(attributeDict["name"]!)

          let shelf: CNList

          if (listByShelfID[shelfInfo.grID!] == nil) {
            shelf = CNList(name: "\(shelfInfo.name)", context: saveContext)
          } else {
            shelf = listByShelfID[shelfInfo.grID!]!
          }

          currentShelves.append(shelf)
          Log.withLine("=", msg:"\(currentShelves)")
        }
      default:
        if (isParsingBookInfo) {
          currentKey = elementName
        }
    }
  }
  
  func trimWhiteSpace(text: String) -> String {
    return text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    switch(elementName) {
    case "book":
      isParsingBookInfo = false
      Log.withLine("-", msg: "\(currentBook?.title)\n\(currentBook?.author?.name)")
    case "title":
      bookInfo.title = bookInfo.title.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
      currentBook = CNBook(title: bookInfo.title, context: saveContext)
      
    case "name":
      authorInfo.name = authorInfo.name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
      currentBook!.author = CNAuthor(firstName: nil, lastName: authorInfo.name, context: saveContext)

    case "review":
      for list in currentShelves {
        list.addBooks([currentBook!])
      }

      currentBook = nil
      currentShelves = []
      bookInfo.title = ""
      authorInfo.name = ""
    default:
      doNothing()
    }
  }
  
  func doNothing() {
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    if (isParsingBookInfo) {
      switch(currentKey) {
        case "title":
          if (bookInfo.title == "") {
            bookInfo.title = string
          } else {
            bookInfo.title += string
          }
        case "name":
          if (authorInfo.name == "") {
            authorInfo.name = string
          } else {
            authorInfo.name += string
          }
        default:
          doNothing()
      }
    }
  }
  
  func parserDidEndDocument(parser: NSXMLParser) {
    NSNotificationCenter.defaultCenter().postNotificationName("goodReadsParseDone", object: nil)
  }
}

