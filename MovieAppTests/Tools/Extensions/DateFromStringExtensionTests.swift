//
//  DateFromStringExtensionTests.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MovieApp

class DateFromStringExtensionTests: QuickSpec {
  override func spec() {
    describe("DateFromStringExtension") {
      var subject: Date?
      var stringValue: String!
      
      context("when initializing with a string not corresponding to the format") {
        beforeEach {
          stringValue = "asdasda"
          subject = Date(string: stringValue)
        }
        
        it("should not initialize a Date object") {
          expect(subject).to(beNil())
        }
      }
      
      context("when initializing with a string corresponding to the format") {
        let expectedTimeInterval: TimeInterval = 1390518600
        
        beforeEach {
          stringValue = "2014-10-24"
          subject = Date(string: stringValue)
        }
        
        it("should initiatialize a date object with the correct value") {
          expect(subject?.timeIntervalSince1970).to(equal(expectedTimeInterval))
        }
      }
      
      //tests checking if when another format is provided the generated value is correct
      //tests checking if when an invalid format is provided a nil value will be returned
    }
  }
}
