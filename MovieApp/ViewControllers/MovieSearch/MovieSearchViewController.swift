//
//  MovieSearchViewController.swift
//  MovieApp
//
//  Created by Dan Andoni on 14.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit
import Alamofire

class MovieSearchViewController: UIViewController, MovieInfosFetcherDelegate, ScrollingListener {
  //MARK:- Outlets
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  //MARK:- iVars
  var searchTermController: MovieSearchTermController?
  var movieInfosFetcher: MovieInfosFetcher?
  var tableViewController: MovieInfosTableViewController?
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
    movieInfosFetcher?.cancelFetching()
  }
  
  @IBAction func textFieldDidChangeText(_ sender: UITextField) {
    searchTermController?.didRefresh(searchTerm: sender.text)
  }
  
  func didPullToRefresh() {
    searchTermController?.stopCurrentSearchTermEvaluation()
    
    guard let searchTerm = searchTextField.text else {
      return
    }
    
    movieInfosFetcher?.shouldSearch(term: searchTerm)
  }
  
  //MARK:- TextField delegate methods
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
  
  //MARK:- Movie infos fetcher delegate
  func didFetch(movieInfos: [MovieInfo]) {
    refreshControl.endRefreshing()
    tableViewController?.reload(with: movieInfos)
  }
  
  //MARK:- ScrollingListener delegate
  func didScroll() {
    view.endEditing(true)
  }
  
  //MARK:- Helpers
  func initializeProperties() {
    movieInfosFetcher = MovieInfosFetcherImpl(httpClient: HTTPClientImpl(), delegate: self)
    
    searchTermController = MovieSearchTermControllerImpl(delegate: movieInfosFetcher)
    
    tableViewController = MovieInfosTableViewControllerImpl(tableView: tableView, delegate: self)
  }
  
  func configureView() {
    refreshControl.tintColor = .darkGray
    refreshControl.addTarget(self, action: #selector(MovieSearchViewController.didPullToRefresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
}
