//
//  MovieInfoTests.swift
//  MovieApp
//
//  Created by Dan Andoni on 17.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MovieApp

class MovieInfoTests: QuickSpec {
  override func spec() {
    describe("MovieInfo") {
      var subject: MovieInfo!
      
      beforeEach {
        subject = MovieInfo()
      }
      
      context("when requesting full poster path") {
        let posterPath = "2DtPSyODKWXluIRV7PVru0SSzja.jpg"
        
        beforeEach {
          subject.posterPath = posterPath
        }
        
        it("should return the correct full path") {
          expect(subject.fullPosterPath).to(equal("http://image.tmdb.org/t/p/w92/2DtPSyODKWXluIRV7PVru0SSzja.jpg"))
        }
      }
      
      context("when requesting property converters") {
        let stringDate = "2014-10-24"
        let date = Date(string: stringDate)
        
        var propertyConverterKey: String?
        var decodeConverter: ((Any?) -> ())?
        var encodeConverter: (() -> Any?)?
        
        beforeEach {
          let propertyConverter = subject.propertyConverters().first
          propertyConverterKey = propertyConverter?.key
          decodeConverter = propertyConverter?.decodeConverter
          encodeConverter = propertyConverter?.encodeConverter
        }
        
        it("should contain a tuple with release date key") {
          expect(propertyConverterKey).to(equal("releaseDate"))
        }
        
        context("when decode converter is provided a nil value") {
          beforeEach {
            decodeConverter?(nil)
          }
          
          it("should leave the realse date with nil value") {
            expect(subject.releaseDate).to(beNil())
          }
        }
        
        context("when decode converter is provided a valid value") {
          beforeEach {
            decodeConverter?(stringDate)
          }
          
          it("should assign a value to release date") {
            expect(String(date:subject.releaseDate!)).to(equal(stringDate))
          }
        }
        
        context("when encoding a nil release date") {
          beforeEach {
            subject.releaseDate = nil
          }
          
          it("should return a nil value from encode converter") {
            expect(encodeConverter?()).to(beNil())
          }
        }
        
        context("when encoding a valid release date") {
          beforeEach {
            subject.releaseDate = date
          }
          
          it("should return a valid string") {
            expect(encodeConverter?() as String?).to(equal(stringDate))
          }
        }
      }
    }
  }
}
