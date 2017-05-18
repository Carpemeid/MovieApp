//
//  ResponseMocker.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

enum ResponseMockerDictionaryKeys: String {
  case headers
  case url
  case data
}

protocol ResponseMocker {
  var dictionary: NSMutableDictionary { get }
  var headers: [String: String] { get }
  var URL: URL { get }
  var URLToReturn: String? { get set }
  var data: Data { get }
  var dataToReturn: Data? { get set }
  var JSON: AnyObject { get }
  
  var pathElementToContain: String { get }
  
  init(config: ResponseMockerConfig)
}

extension ResponseMocker {
  var URL: URL {
    let url = URLToReturn ?? dictionary.value(forKey: ResponseMockerDictionaryKeys.url.rawValue) as! String
    
    return Foundation.URL(string: url)!
  }
  
  var headers: [String: String] {
    return dictionary.value(forKey: ResponseMockerDictionaryKeys.headers.rawValue) as? [String: String] ?? [:]
  }
  
  var data: Data {
    let localData = dataToReturn ?? dictionary.value(forKey: ResponseMockerDictionaryKeys.data.rawValue) as! Data
    
    return localData
  }
  
  var JSON: AnyObject {
    return try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
  }
}

enum ResponseMockerConfig: String {
  case movieInfos
  
  var pathElementToContain: String {
    switch self {
    case .movieInfos: return "&query=fight%20club"
    }
  }
  
  var dictionary: NSMutableDictionary {
    return NSMutableDictionary(contentsOfFile: Bundle(for: ResponseMockerImpl.self).path(forResource: rawValue, ofType: ".plist")!)!
  }
}

class ResponseMockerImpl: ResponseMocker {
  //this to return properties are made for temporary values to be served in case some modifications are needed
  //otherwise after any temporary modifcation due to static nature of the instances, the variables would have to be returned to the initial .plist value
  var URLToReturn: String?
  var dataToReturn: Data?
  let pathElementToContain: String
  let dictionary: NSMutableDictionary
  
  required init(config: ResponseMockerConfig) {
    self.dictionary = config.dictionary
    self.pathElementToContain = config.pathElementToContain
  }
}
