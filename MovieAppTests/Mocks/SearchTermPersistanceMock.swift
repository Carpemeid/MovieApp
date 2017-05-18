//
//  SearchTermPersistanceMock.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

@testable import MovieApp

final class SearchTermsPersistanceMock: SearchTermsPersistance {
  var userSearchTermsToReturn: [String] = []
  var userSearchTerms: [String] {
    return userSearchTermsToReturn
  }
  
  var addParam: String?
  func add(term: String) {
    addParam = term
  }
}
