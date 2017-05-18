//
//  MovieSearchViewControllerTests.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import MovieApp

class MovieSearchViewControllerTests: QuickSpec {
  override func spec() {
    describe("MovieSearchViewController") {
      var subject: MovieSearchViewController!
      var searchTermController: MovieSearchTermControllerMock!
      var movieInfosFetcherMock: MovieInfosFetcherMock!
      
      beforeEach {
        subject = MovieSearchViewController()
        subject.tableView = UITableView()
        subject.searchTextField = UITextField()
        subject.errorView = UIView()
        
        subject.viewDidLoad()
      }
      
      context("when view did load got called") {
        it("should initialize the search term controller") {
          expect(subject.searchTermController).toNot(beNil())
        }
        
        it("should initialize the movie infos fetcher") {
          expect(subject.movieInfosFetcher).toNot(beNil())
        }
        
        it("should initialize the movie infos table view controller") {
          expect(subject.movieInfosTableViewController).toNot(beNil())
        }
        
        it("should initialize suggestion terms table view controller") {
          expect(subject.suggestionTermsTableViewController).toNot(beNil())
        }
        
        it("should assign the correct current table view controller representer") {
          expect(subject.currentTableViewControllerRepresenter === subject.suggestionTermsTableViewController).to(beTrue())
        }
        
        it("should initialize the search terms persistance") {
          expect(subject.searchTermsPersistance).toNot(beNil())
        }
        
        it("should have added a refresh control to the tableview") {
          expect(subject.tableView.refreshControl).toNot(beNil())
        }
      }
      
      context("when clear text field is called") {
        beforeEach {
          subject.searchTextField.text = "test"
          searchTermController = MovieSearchTermControllerMock()
          subject.searchTermController = searchTermController
          movieInfosFetcherMock = MovieInfosFetcherMock()
          subject.movieInfosFetcher = movieInfosFetcherMock
          subject.change(tableViewControllerRepresenter: subject.movieInfosTableViewController)
          subject.clearTextFieldAction(subject)
        }
        
        it("should set the textfield text to nil") {
          //setting textfield's text property to nil, does not nullify it - maybe bug in cocoa
          expect(subject.searchTextField.text).to(equal(""))
        }
        
        it("should call stop current search term evaluation on search term controller") {
          expect(searchTermController.stopCurrentSearchTermEvaluationWasCalled).to(beTrue())
        }
        
        it("should call cancel fetching on movie infost fetcher") {
          expect(movieInfosFetcherMock.cancelFetchingWasCalled).to(beTrue())
        }
        
        it("should change the table view controller representer to the suggestion terms table view controller") {
          expect(subject.currentTableViewControllerRepresenter === subject.suggestionTermsTableViewController).to(beTrue())
        }
      }
      
      context("when did pull to refresh is called") {
        beforeEach {
          searchTermController = MovieSearchTermControllerMock()
          subject.searchTermController = searchTermController
          movieInfosFetcherMock = MovieInfosFetcherMock()
          subject.movieInfosFetcher = movieInfosFetcherMock
        }
        
        context("when textfield text is empty") {
          beforeEach {
            subject.searchTextField.text = nil
            subject.change(tableViewControllerRepresenter: subject.movieInfosTableViewController)
            subject.didPullToRefresh()
          }
          
          it("should call end refreshing on refresh control") {
            expect(subject.refreshControl.isRefreshing).to(beFalse())
          }
          
          it("should change table view controller presenter to suggestions") {
            expect(subject.currentTableViewControllerRepresenter === subject.suggestionTermsTableViewController).to(beTrue())
          }
          
          it("should call stop current search term evaluation on search term controller") {
            expect(searchTermController.stopCurrentSearchTermEvaluationWasCalled).to(beTrue())
          }
          
          it("should call cancel fetching on movie infost fetcher") {
            expect(movieInfosFetcherMock.cancelFetchingWasCalled).to(beTrue())
          }
        }
        
        context("when textfield text is not empty") {
          let searchTerm = "test"
          
          beforeEach {
            subject.searchTextField.text = searchTerm
            
            subject.didPullToRefresh()
          }
          
          it("should call should search on movie infos fetcher with the right term") {
            expect(movieInfosFetcherMock.shouldSearchParam).to(equal(searchTerm))
          }
        }
      }
      
      context("when textfield should return is called") {
        beforeEach {
          subject.searchTextField.becomeFirstResponder()
          _ = subject.textFieldShouldReturn(subject.searchTextField)
        }
        
        it("should resign search text field as first responder") {
          expect(subject.searchTextField.isFirstResponder).to(beFalse())
        }
      }
      
      xcontext("when did fetch is called") {
        var movieInfoItems: [MovieInfo]!
        let searchTerm = "test"
        
        beforeEach {
          movieInfoItems = [MovieInfo()]
          subject.refreshControl.beginRefreshing()
          subject.didFetch(movieInfos: movieInfoItems, for: searchTerm)
        }
        
        it("should end refreshing of refresh control") {
          expect(subject.refreshControl.isRefreshing).to(beFalse())
        }
        
        context("when did fetch was called with a non empty array of results") {
          let movieInfoTitle = "batman"
          var movieInfosTableViewController: MovieInfosTableViewControllerMock!
          var searchTermsPersistance: SearchTermsPersistanceMock!
          
          beforeEach {
            let movieInfo = MovieInfo()
            movieInfo.title = movieInfoTitle
            movieInfoItems = [MovieInfo()]
            subject.tableView.isHidden = true
            subject.errorView.isHidden = false
            movieInfosTableViewController = MovieInfosTableViewControllerMock()
            subject.movieInfosTableViewController = movieInfosTableViewController
            searchTermsPersistance = SearchTermsPersistanceMock()
            subject.searchTermsPersistance = searchTermsPersistance
            subject.didFetch(movieInfos: movieInfoItems, for: searchTerm)
          }
          
          it("should make the table view visible") {
            expect(subject.tableView.isHidden).to(beFalse())
          }
          
          it("should reload the movie infos table view controller with the correct movie infos") {
            let movieInfosTableViewControllerHasReceivedTheSameItems = movieInfosTableViewController.reloadParam?.containsTheSameElements(as: movieInfoItems, condition: {$0.0.title == $0.1.title})
            
            expect(movieInfosTableViewControllerHasReceivedTheSameItems).to(beTrue())
          }
          
          it("should add the search term to the persistance") {
            expect(searchTermsPersistance.addParam).to(equal(searchTerm))
          }
          
          it("should hide the error view") {
            
          }
        }
        
        context("when did fetch was called with an empty array of results") {
          beforeEach {
            
          }
          
          it("should hide table view") {
            
          }
          
          it("should show error view") {
            
          }
          
          it("should reload the movie infos table view controller") {
            
          }
        }
      }
      
      context("when did select is called") {
        beforeEach {
          
        }
        
        it("should ") {
          
        }
      }
      
      context("when did scroll is called") {
        beforeEach {
          
        }
        
        it("should ") {
          
        }
      }
    }
  }
}
