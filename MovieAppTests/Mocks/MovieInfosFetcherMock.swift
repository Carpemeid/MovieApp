//
//  MovieInfosFetcherMock.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

@testable import MovieApp

final class MovieInfosFetcherMock: MovieInfosFetcher {
  var delegateParam: MovieInfosFetcherDelegate?
  var delegateToReturn = MovieInfosFetcherDelegateMock()
  var delegate: MovieInfosFetcherDelegate? {
    get {
      return delegateToReturn
    }
    
    set {
      delegateParam = newValue
    }
  }
  
  var cancelFetchingWasCalled = false
  func cancelFetching() {
    cancelFetchingWasCalled = true
  }
  
  var shouldSearchParam: String?
  func shouldSearch(term: String) {
    shouldSearchParam = term
  }
}
