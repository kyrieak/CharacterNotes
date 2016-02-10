//
//  GRAuthSession.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/5/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation

class GRAuthSession: NSObject, NSURLSessionTaskDelegate {
  func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: (NSURLRequest?) -> Void) {
    Log.withLine("#", msg: "willRedirect")
    NSLog("task: \n\(task.description)")
    NSLog("request: \n\(request.description)")
  }
}