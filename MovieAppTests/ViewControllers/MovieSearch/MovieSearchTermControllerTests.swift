//
//  MovieSearchTermControllerTests.swift
//  MovieApp
//
//  Created by Dan Andoni on 14.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MovieApp

class MovieSearchTermControllerTests: QuickSpec {
  override func spec() {
    describe("MovieSearchTermController") {
      let toleranceRate: TimeInterval = 1.1
      let defaultInterval: TimeInterval = 0.1
      let firstTestWord = "test"
      
      var subject: MovieSearchTermControllerImpl!
      var listener: MovieSearchTermListenerMock!
      
      var dateOfStart: Date!
      
      beforeEach {
        subject = MovieSearchTermControllerImpl(defaultRefreshTime: defaultInterval)
        listener = MovieSearchTermListenerMock()
        subject.delegate = listener
      }
      
      context("when didRefresh is called once") {
        //this test has a chance of failure in case a lot of tests are run in parallel
        //I usually prefer to separate all the use cases in separate it's, but due to the nature of the test [time + correct param] it does not make sense to duplicate this code and also because waitUntil if present in too many tests [think about thousands] causes problems on the machines performing the testing [we had problems with mac mini basically having the Xcode crashed because of too many parallel unfinished tests]
        it("should call shouldSearch on the delegate after specified time with the correct term") {
          waitUntil { done in
            listener.callback = { term, dateOfEnd in
              let hasFiredOnTime = abs(dateOfEnd.timeIntervalSince(dateOfStart) - defaultInterval) < toleranceRate
              expect(hasFiredOnTime).to(beTrue())
              expect(term).to(equal(firstTestWord))
              done()
            }
            
            dateOfStart = Date()
            subject.didRefresh(searchTerm: firstTestWord)
          }
        }
      }
      
      context("when didRefresh is called twice consecutively") {
        let secondTestWord = "testtest"
        let breakBetweenCalls: TimeInterval = 0.05
        
        it("should call shouldSearch only after the second time interval has passed with the correct search term") {
          waitUntil { done in
            listener.callback = { term, dateOfEnd in
              let hasFiredOnTime = abs(dateOfEnd.timeIntervalSince(dateOfStart) - defaultInterval - breakBetweenCalls) < toleranceRate
              expect(hasFiredOnTime).to(beTrue())
              expect(term).to(equal(secondTestWord))
              done()
            }
            
            dateOfStart = Date()
            subject.didRefresh(searchTerm: firstTestWord)
            Timer.scheduledTimer(withTimeInterval: breakBetweenCalls, repeats: false, block: { _ in
              subject.didRefresh(searchTerm: secondTestWord)
            })
          }
        }
      }
      
      context("when didRefresh receives nil parameter") {
        it("should not refresh the delegate after the default time passes") {
          waitUntil { done in
            subject.didRefresh(searchTerm: nil)
            Timer.scheduledTimer(withTimeInterval: defaultInterval * 1.5, repeats: false, block: { _ in
              expect(listener.shouldSearchParam).to(beNil())
              done()
            })
          }
        }
      }
    }
  }
}
