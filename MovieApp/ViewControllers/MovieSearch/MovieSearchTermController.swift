//
//  MovieSearchTermController.swift
//  MovieApp
//
//  Created by Dan Andoni on 14.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

protocol MovieSearchTermListener: class {
  func shouldSearch(term: String)
}

protocol MovieSearchTermController {
  var delegate: MovieSearchTermListener? { get set }
  
  func didRefresh(searchTerm: String?)
  
  func stopCurrentSearchTermEvaluation()
}

final class MovieSearchTermControllerImpl: MovieSearchTermController {
  weak var delegate: MovieSearchTermListener?
  
  private let defaultRefreshTime: TimeInterval
  
  init(delegate: MovieSearchTermListener?, defaultRefreshTime: TimeInterval = 1.5) {
    self.defaultRefreshTime = defaultRefreshTime
    self.delegate = delegate
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
  
  func stopCurrentSearchTermEvaluation() {
    timer?.invalidate()
  }
}
