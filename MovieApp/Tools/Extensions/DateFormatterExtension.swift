//
//  DateFormatterExtension.swift
//  MovieApp
//
//  Created by Dan Andoni on 15.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

extension DateFormatter {
  static let defaultFormat = "yyyy-mm-dd"
  static let movieInfoDisplayFormat = "dd MMM YYYY"
  
  static func formatter(with format: String) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter
  }
}
