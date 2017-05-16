//
//  MovieInfosTableViewController.swift
//  MovieApp
//
//  Created by Dan Andoni on 16.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit

protocol ScrollingListener {
  func didScroll()
}

protocol MovieInfosTableViewController: UITableViewDelegate, UITableViewDataSource {
  var delegate: ScrollingListener? { get set }
  
  func reload(with movieInfos: [MovieInfo])
}

final class MovieInfosTableViewControllerImpl: NSObject, MovieInfosTableViewController {
  private static let sectionsCount = 1
  
  //MARK:- iVars
  var delegate: ScrollingListener?
  
  private weak var tableView: UITableView?
  private var movieInfos: [MovieInfo] = []
  
  init(tableView: UITableView, delegate: ScrollingListener?) {
    self.tableView = tableView
    self.delegate = delegate
    
    super.init()
    
    self.tableView?.delegate = self
    self.tableView?.dataSource = self
  }
  
  //MARK:- UIScrollView delegate methods
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    delegate?.didScroll()
  }
  
  //MARK:- Tableview delegate methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return MovieInfosTableViewControllerImpl.sectionsCount
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieInfos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: MovieInfoCell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.identifier, for: indexPath) as! MovieInfoCell
    
    cell.configure(with: movieInfos[indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }
  
  //MARK:- Actions
  func reload(with movieInfos: [MovieInfo]) {
    self.movieInfos = movieInfos
    tableView?.reloadData()
  }
}
