//
//  SuggestionTermsTableViewController.swift
//  MovieApp
//
//  Created by Dan Andoni on 17.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit

protocol SuggestionTermsListener: class {
  func didSelect(term: String)
}

//need to inject suggestion terms fetcher
final class SuggestionTermsTableViewController: BaseTableViewController {
  private weak var suggestionTermsListener: SuggestionTermsListener?
  private var suggestionTerms: [String] {
    return searchTermsPersistance.userSearchTerms
  }
  private let searchTermsPersistance: SearchTermsPersistance
  
  init(tableView: UITableView, searchTermsPersistance: SearchTermsPersistance, scrollingListener: ScrollingListener?, suggestionTermsListener: SuggestionTermsListener? ) {
    self.suggestionTermsListener = suggestionTermsListener
    self.searchTermsPersistance = searchTermsPersistance
    super.init(tableView: tableView, scrollingListener: scrollingListener)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return suggestionTerms.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    cell.textLabel?.text = suggestionTerms[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard suggestionTerms.count > indexPath.row else {
      return
    }
    
    suggestionTermsListener?.didSelect(term: suggestionTerms[indexPath.row])
  }
}
