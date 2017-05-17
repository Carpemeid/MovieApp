//
//  BaseTableViewController.swift
//  MovieApp
//
//  Created by Dan Andoni on 17.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit

protocol ScrollingListener {
  func didScroll()
}

typealias TableViewControllerRepresenter = UITableViewDelegate & UITableViewDataSource

class BaseTableViewController: NSObject, TableViewControllerRepresenter {
  private var scrollingListener: ScrollingListener?
  
  private(set) weak var tableView: UITableView?
  
  init(tableView: UITableView, scrollingListener: ScrollingListener?) {
    self.scrollingListener = scrollingListener
    self.tableView = tableView
  }
  
  //MARK:- UIScrollView delegate methods
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollingListener?.didScroll()
  }
  
  //MARK:- Tableview delegate methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    assert(false, "should be overriden by children")
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    assert(false, "should be overriden by children")
    return UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1
  }
}
