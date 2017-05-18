//
//  MovieInfosFetcherDelegateMock.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

@testable import MovieApp

final class MovieInfosFetcherDelegateMock: MovieInfosFetcherDelegate {
  var didFetchParams: (movieInfos: [MovieInfo], term: String)?
  func didFetch(movieInfos: [MovieInfo], for term: String) {
    didFetchParams = (movieInfos, term)
  }
}
