//
//  MovieSearchViewController.swift
//  MovieApp
//
//  Created by Dan Andoni on 14.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit

protocol MovieSearchTermListener: class {
  func shouldSearch(term: String)
}

class MovieSearchViewController: UIViewController, MovieSearchTermListener {
  //MARK:- Outlets
  @IBOutlet weak var searchTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  //MARK:- iVars
  var searchTermController: MovieSearchTermController?
  
  //MARK:- View life cycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initialize()
  }
  
  //MARK:- Events
  @IBAction func clearTextFieldAction(_ sender: Any) {
    searchTextField.text = nil
    searchTermController?.didRefresh(searchTerm: nil)
  }
  
  @IBAction func textFieldDidChangeText(_ sender: UITextField) {
    searchTermController?.didRefresh(searchTerm: sender.text)
  }
  
  //MARK:- TextField delegate methods
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    view.endEditing(true)
    return true
  }
  
  //MARK:- Search term delegate methods
  func shouldSearch(term: String) {
    
  }
  
  //MARK:- Helpers
  func initialize() {
    //search term controller
    searchTermController = MovieSearchTermControllerImpl()
    searchTermController?.delegate = self
  }
}
