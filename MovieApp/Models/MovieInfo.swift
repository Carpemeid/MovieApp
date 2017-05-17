//
//  MovieInfo.swift
//  MovieApp
//
//  Created by Dan Andoni on 15.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import EVReflection

class MovieInfo: EVNetworkingObject {
  private static let defaultPosterBasePath = "http://image.tmdb.org/t/p/w92/"
  private static let propertyConverterKey = "releaseDate"
  
  var posterPath: String?
  var title: String?
  var releaseDate: Date?
  var overview: String?
  
  var fullPosterPath: String? {
    guard let posterPath = posterPath else {
      return nil
    }
    
    return MovieInfo.defaultPosterBasePath + posterPath
  }
  
  func decodeConverter(value: Any?) -> Void {
    guard let stringValue = value as? String else {
      return
    }
    
    releaseDate = Date(string: stringValue)
  }
  
  func encodeConverter() -> String? {
    guard let releaseDate = self.releaseDate else {
      return nil
    }
    
    return String(date: releaseDate)
  }
  
  override func propertyConverters() -> [(key: String, decodeConverter: ((Any?) -> ()), encodeConverter: (() -> Any?))] {
    return [(
        key: MovieInfo.propertyConverterKey,
        decodeConverter: decodeConverter,
        encodeConverter: encodeConverter
      )]
  }
}
