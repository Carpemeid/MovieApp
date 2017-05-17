//
//  MovieInfosTableViewController.swift
//  MovieApp
//
//  Created by Dan Andoni on 16.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit

protocol MovieInfosTableViewController: TableViewControllerRepresenter {
  func reload(with movieInfos: [MovieInfo])
}

final class MovieInfosTableViewControllerImpl: BaseTableViewController, MovieInfosTableViewController {
  private var movieInfos: [MovieInfo] = []
  
  //MARK:- Table view methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieInfos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: MovieInfoCell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.identifier, for: indexPath) as! MovieInfoCell
    
    cell.configure(with: movieInfos[indexPath.row])
    
    return cell
  }
  
  //MARK:- Actions
  func reload(with movieInfos: [MovieInfo]) {
    self.movieInfos = movieInfos
    tableView?.reloadData()
  }
}
