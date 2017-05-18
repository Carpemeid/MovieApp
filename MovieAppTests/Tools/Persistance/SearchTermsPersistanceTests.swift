//
//  SearchTermsPersistanceTests.swift
//  MovieApp
//
//  Created by Dan Andoni on 17.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MovieApp

class SearchTermsPersistanceTests: QuickSpec {
  override func spec() {
    describe("SearchTermsPersistance") {
      let persistanceArrayKey = "userSearchTermsKey"
      let term = "movie"
      
      var subject: SearchTermsPersistanceImpl!
      
      beforeEach {
        // cleaning user defaults
        UserDefaults.standard.removePersistentDomain(forName: Bundle(for: MovieSearchViewController.self).bundleIdentifier!)
        subject = SearchTermsPersistanceImpl()
      }
      
      context("when appending a term") {
        beforeEach {
          subject.add(term: term)
        }
        
        it("should add the term to the first position in the user defaults stored array") {
          let containsTerm = (UserDefaults.standard.array(forKey: persistanceArrayKey) as? [String])?.contains(term)
          
          expect(containsTerm).to(beTrue())
        }
        
        context("when term already exists") {
          var containsDuplicates: Bool?
          
          beforeEach {
            subject.add(term: term)
            
            containsDuplicates = !((UserDefaults.standard.array(forKey: persistanceArrayKey) as? [String])?.filter { $0 == term }.count == 1)
          }
          
          it("should not contain duplicates in user defaults stored array") {
            expect(containsDuplicates).to(beFalse())
          }
        }
        
        context("when storage already contains 10 distinct items") {
          let oldestTerm = "9"
          let distinctItems = ["0", "1", "2", "3", "4", "5", "6", "7", "8", oldestTerm]
          
          beforeEach {
            UserDefaults.standard.set(distinctItems, forKey: persistanceArrayKey)
            //in order to reset the lazy property userSearchTerms to contain the added values from the user defaults
            subject = SearchTermsPersistanceImpl()
            subject.add(term: term)
          }
          
          it("should contain the term to be added in user defaults stored array on the first position") {
            expect(UserDefaults.standard.array(forKey: persistanceArrayKey)?.first as? String).to(equal(term))
          }
          
          it("should contain 10 elements in the user defaults stored array") {
            expect(UserDefaults.standard.array(forKey: persistanceArrayKey)?.count).to(equal(10))
          }
          
          it("should not contain the oldest term") {
            let containsOldestTerm = (UserDefaults.standard.array(forKey: persistanceArrayKey) as? [String])?.contains(oldestTerm)
            expect(containsOldestTerm).to(beFalse())
          }
        }
      }
      
      context("when requesting userSearchTerms") {
        let searchTerms: [String] = ["one", "two"]
        
        beforeEach {
          UserDefaults.standard.set(searchTerms, forKey: persistanceArrayKey)
          subject = SearchTermsPersistanceImpl()
        }
        
        it("should return the correct search terms") {
          expect(subject.userSearchTerms.containsTheSameElements(as: searchTerms)).to(beTrue())
        }
        
        context("when no previous terms exist") {
          beforeEach {
            UserDefaults.standard.removeObject(forKey: persistanceArrayKey)
          }
          
          it("should return empty array") {
            expect(subject.userSearchTerms.isEmpty).to(beTrue())
          }
        }
        
        context("when an item has been added") {
          beforeEach {
            subject.add(term: term)
          }
          
          it("should be contained in the userSearchTerms") {
            expect(subject.userSearchTerms.contains(term)).to(beTrue())
          }
        }
      }
    }
  }
}
