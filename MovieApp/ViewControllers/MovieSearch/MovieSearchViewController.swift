//
//  MovieSearchViewController.swift
//  MovieApp
//
//  Created by Dan Andoni on 14.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit
import Alamofire

class MovieSearchViewController: UIViewController, MovieInfosFetcherDelegate, ScrollingListener, SuggestionTermsListener {
  //MARK:- Outlets
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var errorView: UIView!
  
  //MARK:- iVars
  var searchTermController: MovieSearchTermController!
  var movieInfosFetcher: MovieInfosFetcher!
  var movieInfosTableViewController: MovieInfosTableViewController!
  var suggestionTermsTableViewController: SuggestionTermsTableViewController!
  var currentTableViewControllerRepresenter: TableViewControllerRepresenter!
  let searchTermsPersistance: SearchTermsPersistance = SearchTermsPersistanceImpl.sharedInstance
  
  let refreshControl: UIRefreshControl = UIRefreshControl()
  
  //MARK:- View life cycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeProperties()
    configureView()
  }
  
  //MARK:- Events
  @IBAction func clearTextFieldAction(_ sender: Any) {
    searchTextField.text = nil
    textFieldDidChangeText(searchTextField)
  }
  
  @IBAction func textFieldDidChangeText(_ sender: UITextField) {
    guard let searchTerm = sender.text, !searchTerm.isEmpty else {
      stopCurrentProcesses()
      change(tableViewControllerRepresenter: suggestionTermsTableViewController)
      return
    }
    
    movieInfosTableViewController.reload(with: [])
    change(tableViewControllerRepresenter: movieInfosTableViewController)
    
    searchTermController?.didRefresh(searchTerm: searchTerm)
  }
  
  func didPullToRefresh() {
    stopCurrentProcesses()
    
    guard let searchTerm = searchTextField.text, !searchTerm.isEmpty else {
      refreshControl.endRefreshing()
      change(tableViewControllerRepresenter: suggestionTermsTableViewController)
      return
    }
    
    movieInfosFetcher?.shouldSearch(term: searchTerm)
  }
  
  //MARK:- TextField delegate methods
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.resignFirstResponder()
    return true
  }
  
  //MARK:- Movie infos fetcher delegate
  func didFetch(movieInfos: [MovieInfo], for term: String) {
    refreshControl.endRefreshing()
    
    tableView.isHidden = movieInfos.isEmpty
    errorView.isHidden = !movieInfos.isEmpty
    
    movieInfosTableViewController?.reload(with: movieInfos)
    
    if !movieInfos.isEmpty {
      searchTermsPersistance.append(term: term)
    }
  }
  
  //MARK:- SuggestionTermsListener
  func didSelect(term: String) {
    searchTextField.text = term
    
    textFieldDidChangeText(searchTextField)
  }
  
  //MARK:- ScrollingListener
  func didScroll() {
    searchTextField.resignFirstResponder()
  }
  
  //MARK:- Helpers
  func stopCurrentProcesses() {
    searchTermController?.stopCurrentSearchTermEvaluation()
    movieInfosFetcher?.cancelFetching()
  }
  
  func change(tableViewControllerRepresenter: TableViewControllerRepresenter) {
    guard currentTableViewControllerRepresenter !== tableViewControllerRepresenter else {
      return
    }
    
    defer { currentTableViewControllerRepresenter = tableViewControllerRepresenter }
    
    tableView.delegate = tableViewControllerRepresenter
    tableView.dataSource = tableViewControllerRepresenter
    
    tableView.reloadData()
  }
  
  func initializeProperties() {
    movieInfosFetcher = MovieInfosFetcherImpl(httpClient: HTTPClientImpl(), delegate: self)
    
    searchTermController = MovieSearchTermControllerImpl(delegate: movieInfosFetcher)
    
    movieInfosTableViewController = MovieInfosTableViewControllerImpl(tableView: tableView, scrollingListener: self)
    
    suggestionTermsTableViewController = SuggestionTermsTableViewController(tableView: tableView, searchTermsPersistance: searchTermsPersistance, scrollingListener: self, suggestionTermsListener: self)
  }
  
  func configureView() {
    //refresh control
    refreshControl.tintColor = .darkGray
    refreshControl.addTarget(self, action: #selector(MovieSearchViewController.didPullToRefresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    //initial table view state
    change(tableViewControllerRepresenter: suggestionTermsTableViewController)
  }
}
