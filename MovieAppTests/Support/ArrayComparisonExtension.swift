//
//  ArrayComparisonExtension.swift
//  MovieApp
//
//  Created by Dan Andoni on 17.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import Foundation

extension Array {
  func containsTheSameElements(as array: [Element], condition: @escaping (Element, Element) -> Bool) -> Bool {
    var localCopy = array
    
    let countOfUncommonElements = reduce(0) { (uncommonElementsCount: Int, item: Element) -> Int in
      if let index = localCopy.index(where: {condition(item, $0)}) {
        localCopy.remove(at: index)
        return uncommonElementsCount
      } else {
        return uncommonElementsCount + 1
      }
    }
    
    return countOfUncommonElements == 0 && count == array.count
  }
}

extension Array where Element: Equatable {
  func containsTheSameElements(as array: [Element]) -> Bool {
    return containsTheSameElements(as: array, condition: { $0 == $1 })
  }
}
