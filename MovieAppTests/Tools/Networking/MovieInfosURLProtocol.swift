//
//  MovieInfosURLProtocol.swift
//  MovieApp
//
//  Created by Dan Andoni on 18.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

class MovieInfosURLProtocol: BaseURLProtocol {
  static let responseMocker: ResponseMockerImpl = ResponseMockerImpl(config: .movieInfos)
  
  override class func responseToReturn() -> ResponseMocker! {
    return responseMocker
  }
}
