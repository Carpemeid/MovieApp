//
//  MovieInfosFetcherTests.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Alamofire

@testable import MovieApp

class MovieInfosFetcherTests: QuickSpec {
  override func spec() {
    describe("MovieInfosFetcher") {
      var subject: MovieInfosFetcherImpl!
      var fetcherDelegate: MovieInfosFetcherDelegateMock!
      
      beforeEach {
        let httpClient = HTTPClientImpl()
        fetcherDelegate = MovieInfosFetcherDelegateMock()
        subject = MovieInfosFetcherImpl(httpClient: httpClient, delegate: fetcherDelegate)
      }
      
      context("when should search term with encodable url") {
        let searchTerm = "fight%20club"
        
        beforeEach {
          let urlSessionConfiguration = URLSessionConfiguration.default
          urlSessionConfiguration.protocolClasses?.insert(MovieInfosURLProtocol.self, at: 0)
          
          let httpClient = HTTPClientImpl(sessionManager: SessionManager(configuration: urlSessionConfiguration))
          fetcherDelegate = MovieInfosFetcherDelegateMock()
          
          subject = MovieInfosFetcherImpl(httpClient: httpClient, delegate: fetcherDelegate)
          
          subject.shouldSearch(term: searchTerm)
        }
        
        it("should return the correct movie infos to the delegate") {
          expect(fetcherDelegate.didFetchParams?.movieInfos.count).toEventually(equal(14))
        }
        
        it("should return the correct search term to the delegate") {
          expect(fetcherDelegate.didFetchParams?.term).toEventually(equal(searchTerm))
        }
      }
    }
  }
}
