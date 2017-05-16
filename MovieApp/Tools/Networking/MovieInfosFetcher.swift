//
//  MovieInfosFetcher.swift
//  MovieApp
//
//  Created by Dan Andoni on 16.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Alamofire

protocol MovieInfosFetcherDelegate {
  func didFetch(movieInfos: [MovieInfo])
}

protocol MovieInfosFetcher: MovieSearchTermListener {
  var delegate: MovieInfosFetcherDelegate? { get set }
  
  func cancelFetching()
}

final class MovieInfosFetcherImpl: MovieInfosFetcher {
  private let httpClient: HTTPClient
  private var currentRequest: DataRequest?
  
  var delegate: MovieInfosFetcherDelegate?
  
  init(httpClient: HTTPClient, delegate: MovieInfosFetcherDelegate?) {
    self.httpClient = httpClient
    self.delegate = delegate
  }
  
  func shouldSearch(term: String) {
    currentRequest?.cancel()
    currentRequest = httpClient.getMovieInfos(for: term) { [weak self] movieInfos in
      self?.delegate?.didFetch(movieInfos: movieInfos)
    }
  }
  
  func cancelFetching() {
    currentRequest?.cancel()
  }
}
