//
//  MovieSearchTermController.swift
//  MovieApp
//
//  Created by Dan Andoni on 14.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

protocol MovieSearchTermController {
  var delegate: MovieSearchTermListener? { get set }
  
  func didRefresh(searchTerm: String?)
}

final class MovieSearchTermControllerImpl: MovieSearchTermController {
  weak var delegate: MovieSearchTermListener?
  
  private let defaultRefreshTime: TimeInterval
  
  init(defaultRefreshTime: TimeInterval = 1.5) {
    self.defaultRefreshTime = defaultRefreshTime
  }
  
  private var timer: Timer?
  
  func didRefresh(searchTerm: String?) {
    timer?.invalidate()
    
    guard let searchTerm = searchTerm else {
      return
    }
    
    timer = Timer.scheduledTimer(withTimeInterval: defaultRefreshTime, repeats: false, block: { [weak self] _ in
      self?.delegate?.shouldSearch(term: searchTerm)
    })
  }
}
