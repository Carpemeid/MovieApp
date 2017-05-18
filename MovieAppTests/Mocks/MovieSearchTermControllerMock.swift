//
//  MovieSearchTermControllerMock.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

@testable import MovieApp

final class MovieSearchTermControllerMock: MovieSearchTermController {
  var didRefreshParam: String?
  func didRefresh(searchTerm: String) {
    didRefreshParam = searchTerm
  }
  
  var stopCurrentSearchTermEvaluationWasCalled = false
  func stopCurrentSearchTermEvaluation() {
    stopCurrentSearchTermEvaluationWasCalled = true
  }
}
