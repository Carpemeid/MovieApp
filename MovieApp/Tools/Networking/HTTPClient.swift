//
//  HTTPClient.swift
//  MovieApp
//
//  Created by Dan Andoni on 15.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Alamofire

protocol HTTPClient {
  func getMovieInfos(for term: String, closure: @escaping ([MovieInfo]) -> Void) -> DataRequest
}

final class HTTPClientImpl: HTTPClient {
  private static let defaultBaseURL = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query="
  
  private func urlForTerm(term: String) -> String {
    return HTTPClientImpl.defaultBaseURL + term
  }
  
  func getMovieInfos(for term: String, closure: @escaping ([MovieInfo]) -> Void) -> DataRequest {
    return request(urlForTerm(term: term)).responseObject { (response: DataResponse<MovieInfosResponse>) in
      closure(response.value?.results ?? [])
    }
  }
}
