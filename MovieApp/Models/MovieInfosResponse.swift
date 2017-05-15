//
//  MovieInfosResponse.swift
//  MovieApp
//
//  Created by Dan Andoni on 15.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation
import EVReflection

class MovieInfosResponse: EVNetworkingObject {
  var results: [MovieInfo] = [MovieInfo]()
}
