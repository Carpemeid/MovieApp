//
//  BaseURLProtocol.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

enum RequestProperty: String {
  case isHandeled
}

public class BaseURLProtocol: URLProtocol {
  class func responseToReturn() -> ResponseMocker! {
    //Base URL Protocol response to return must be overriden
    return nil
  }
  
  override public class func canInit(with request: URLRequest) -> Bool {
    guard let hasBeenProcessed =  URLProtocol.property(forKey: RequestProperty.isHandeled.rawValue, in: request) as? Bool, hasBeenProcessed else {
      return request.url?.absoluteString.contains(responseToReturn().pathElementToContain) ?? false
    }
    
    return false
  }
  
  override public class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  override public class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
    return super.requestIsCacheEquivalent(a, to: b)
  }
  
  override public func startLoading() {
    let mutableRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
    URLProtocol.setProperty(true, forKey: RequestProperty.isHandeled.rawValue, in: mutableRequest)
    
    let response = HTTPURLResponse(url: type(of:self).responseToReturn().URL, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: type(of:self).responseToReturn().headers)
    
    client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: URLCache.StoragePolicy.allowed)
    client?.urlProtocol(self, didLoad: type(of:self).responseToReturn().data)
    client?.urlProtocolDidFinishLoading(self)
  }
  
  // is required to be overriden
  public override func stopLoading() {
    
  }
}
