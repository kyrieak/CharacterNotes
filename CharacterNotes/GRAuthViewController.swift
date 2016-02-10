//
//  GoodreadsOauth.swift
//  CharacterNotes
//
//  Created by Kyrie Kopczynski on 2/5/16.
//  Copyright © 2016 KyrieKopczynski. All rights reserved.
//

import Foundation
import UIKit

class GRAuthViewController: UIViewController, UIWebViewDelegate {
  let authURL = NSURL(string: "https://www.goodreads.com/oauth/request_token?key=McIWA9UMcPsNntgynxOrw")!
  let session: NSURLSession

  var webView: UIWebView?
  
  required init?(coder aDecoder: NSCoder) {
    session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: GRAuthSession(), delegateQueue: nil)
    
    super.init(coder: aDecoder)
    session.dataTaskWithRequest(NSURLRequest(URL: authURL), completionHandler: {(data: NSData?, resp: NSURLResponse?, error: NSError?) -> Void in
      Log.withLine("r", msg: "response:\n\(resp)")
      Log.withLine("e", msg: "error:\n\(error)")
    }).resume()
  }
  
  override func viewDidLoad() {
    webView = self.view.viewWithTag(1) as? UIWebView

    webView!.loadRequest(NSURLRequest(URL: authURL))
  }
  
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if (request.URL!.absoluteString.containsString("goodreads")) {
//      Log.withLine("s", msg: "should load url w goodreads")
      return true
    } else {
      return false
    }
  }
  
  func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    Log.withSpace("webView:didFailLoadWithError\n\n\(error)")
  }
  
  func webViewDidStartLoad(webView: UIWebView) {
    Log.withSpace("webViewDidStartLoad")
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    Log.withSpace("webViewDidFinishLoad")
  }
}