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
  private static let releaseDateFormat = "yyyy-mm-dd"
  private static let defaultPosterBasePath = "http://image.tmdb.org/t/p/w92/"
  
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
  
  override func propertyConverters() -> [(key: String, decodeConverter: ((Any?) -> ()), encodeConverter: (() -> Any?))] {
    return [(
        key: "releaseDate",
        decodeConverter: { (value: Any?) -> Void in
          guard let stringValue = value as? String else {
            return
          }
          
          self.releaseDate = Date(string: stringValue, format: MovieInfo.releaseDateFormat)
        },
        encodeConverter: {
          guard let releaseDate = self.releaseDate else {
            return nil
          }
          
          return String(date: releaseDate, format: MovieInfo.releaseDateFormat)
        }
      )]
  }
}
