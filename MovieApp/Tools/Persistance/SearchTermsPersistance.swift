//
//  SearchTermsPersistance.swift
//  MovieApp
//
//  Created by Dan Andoni on 17.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

/// Entity used for storing successful search terms
protocol SearchTermsPersistance {
  var userSearchTerms: [String] { get }
  
  func add(term: String)
}

final class SearchTermsPersistanceImpl: SearchTermsPersistance {
  private static let userSearchTermsKey = "userSearchTermsKey"
  private static let countLimit = 10
  
  static let sharedInstance = SearchTermsPersistanceImpl()
  
  lazy var userSearchTerms: [String] = {
    return UserDefaults.standard.stringArray(forKey: SearchTermsPersistanceImpl.userSearchTermsKey) ?? []
  }()
  
  func add(term: String) {
    //this allows to refresh the position of the searched terms in case the user searches for it again in the same time avoinding duplicates 
    if let index = userSearchTerms.index(of: term) {
      userSearchTerms.remove(at: index)
    }
    
    userSearchTerms.insert(term, at: 0)
    
    if userSearchTerms.count > SearchTermsPersistanceImpl.countLimit {
      userSearchTerms.remove(at: SearchTermsPersistanceImpl.countLimit)
    }
    
    save(terms: userSearchTerms)
  }
  
  private func save(terms: [String]) {
    UserDefaults.standard.set(terms, forKey: SearchTermsPersistanceImpl.userSearchTermsKey)
  }
}
