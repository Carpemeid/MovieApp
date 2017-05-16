//
//  DateFromStringExtension.swift
//  MovieApp
//
//  Created by Dan Andoni on 15.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

extension Date {
  init?(string: String, format: String = DateFormatter.defaultFormat) {
    guard let date = DateFormatter.formatter(with: format).date(from: string) else {
      return nil
    }
    
    self = date
  }
}
