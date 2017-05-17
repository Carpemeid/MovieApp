//
//  DateFormatterExtensionTests.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MovieApp

class DateFormatterExtensionTests: QuickSpec {
  override func spec() {
    describe("DateFormatterExtension") {
      var subject: DateFormatter?
      
      context("when a date formatter with a format is requested") {
        let format = "yyyy-mm-dd"
        
        beforeEach {
          subject = DateFormatter.formatter(with: format)
        }
        
        it("should return a date formatter with the correct format") {
          expect(subject?.dateFormat).to(equal(format))
        }
      }
    }
  }
}
