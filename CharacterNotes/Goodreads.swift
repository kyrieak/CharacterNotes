//
//  Goodreads.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/1/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import CoreData

class Goodreads: NSObject, NSXMLParserDelegate {
  let userID: Int
  let session = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
  let saveContext: NSManagedObjectContext
  private var bookInfo = [String: String]()
  private var isParsingBookInfo = false
  private var currentKey: String = ""
  private var currentBook: CNBook?
  private var authorName = ""
  
  init(userID: Int, saveContext: NSManagedObjectContext) {
    self.userID = userID
    self.saveContext = saveContext
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
      default:
        if (isParsingBookInfo) {
          currentKey = elementName
        }
    }
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    switch(elementName) {
    case "book":
      isParsingBookInfo = false
      Log.withLine("-", msg: "\(currentBook?.title)\n\(currentBook?.author?.name)")
      bookInfo["title"] = nil
      bookInfo["name"]  = nil
    case "title":
      let bookTitle = bookInfo["title"]?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
      if (bookTitle != nil) {
        currentBook = CNBook(title: bookTitle!, context: saveContext)
      }
    case "name":
      let authorName = bookInfo["name"]?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
      if (authorName != nil) {
        currentBook!.author = CNAuthor(firstName: nil, lastName: authorName!, context: saveContext)
      }
    default:
      doNothing()
    }
  }
  
  func doNothing() {
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    if (isParsingBookInfo) {
      switch(currentKey) {
        case "title", "name":
          if (bookInfo[currentKey] == nil) {
            bookInfo[currentKey] = string
          } else {
            bookInfo[currentKey]! += string
        }
        default:
        doNothing()
      }
    }
  }
  
}

