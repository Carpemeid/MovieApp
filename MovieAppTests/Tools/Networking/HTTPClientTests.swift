//
//  HTTPClientTests.swift
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

class HTTPClientTests: QuickSpec {
  override func spec() {
    describe("HTTPClient") {
      var itemsCount: Int!
      var subject: HTTPClientImpl!
      
      beforeEach {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.protocolClasses?.insert(MovieInfosURLProtocol.self, at: 0)
        
        subject = HTTPClientImpl(sessionManager: SessionManager(configuration: urlSessionConfiguration))
      }
      
      context("when requesting a valid term") {
        beforeEach {
          // predefined items in the locally saved .plist
          itemsCount = 14
        }
        
        it("should return an array of items") {
          waitUntil { done in
            _ = subject.getMovieInfos(for: "fight%20club", closure: { (movieInfos: [MovieInfo]) in
              expect(movieInfos.count).to(equal(itemsCount))
              done()
            })
          }
        }
      }
      
      context("when requesting an invalid term") {
        beforeEach {
          itemsCount = 0
        }
        
        it("should return an array of items") {
          waitUntil { done in
            _ = subject.getMovieInfos(for: "blablabla%20car", closure: { (movieInfos: [MovieInfo]) in
              expect(movieInfos.count).to(equal(itemsCount))
              done()
            })
          }
        }
      }
    }
  }
}
