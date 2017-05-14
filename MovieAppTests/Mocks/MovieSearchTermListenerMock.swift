//
//  MovieSearchTermListenerMock.swift
//  MovieApp
//
//  Created by Dan Andoni on 14.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

@testable import MovieApp

final class MovieSearchTermListenerMock: MovieSearchTermListener {
  var callback: ((_ term: String, _ wasCalledAtDate: Date) -> Void)?
  
  func shouldSearch(term: String) {
    callback?(term, Date())
  }
}
