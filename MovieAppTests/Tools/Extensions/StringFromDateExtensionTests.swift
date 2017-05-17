//
//  StringFromDateExtensionTests.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MovieApp

class StringFromDateExtensionTests: QuickSpec {
  override func spec() {
    describe("StringFromDateExtension") {
      var subject: String?
      
      context("when provided a string according to the format") {
        let stringValue = "2014-10-24"
        let timeIntervalSince1970: TimeInterval = 1390518600
        
        beforeEach {
          subject = String(date: Date(timeIntervalSince1970: timeIntervalSince1970))
        }
        
        it("should initialize a correct date string with a correct format") {
          expect(subject).to(equal(stringValue))
        }
      }
      
      //tests checking if when another format is provided the generated value is correct
      //tests checking if when an invalid format is provided a nil value will be returned
    }
  }
}
