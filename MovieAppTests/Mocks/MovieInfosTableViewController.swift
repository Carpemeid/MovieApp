//
//  MovieInfosTableViewController.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit

@testable import MovieApp

final class MovieInfosTableViewControllerMock: NSObject, MovieInfosTableViewController {
  var reloadParam: [MovieInfo]?
  func reload(with movieInfos: [MovieInfo]) {
    reloadParam = movieInfos
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
}
