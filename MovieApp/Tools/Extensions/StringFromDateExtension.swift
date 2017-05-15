//
//  StringFromDateExtension.swift
//  MovieApp
//
//  Created by Dan Andoni on 15.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

extension String {
  init(date: Date, format: String) {
    self = DateFormatter.formatter(with: format).string(from: date)
  }
}
