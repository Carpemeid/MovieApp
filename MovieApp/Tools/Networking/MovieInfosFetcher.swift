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
  func didFetch(movieInfos: [MovieInfo], for term: String)
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
    
    guard let urlEncoded = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
      delegate?.didFetch(movieInfos: [], for: term)
      return
    }
    
    currentRequest = httpClient.getMovieInfos(for: urlEncoded) { [weak self] movieInfos in
      self?.delegate?.didFetch(movieInfos: movieInfos, for: term)
    }
  }
  
  func cancelFetching() {
    currentRequest?.cancel()
  }
}
