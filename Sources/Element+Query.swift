//
//  Element+Query.swift
//  Reindeer
//
//  Created by Khoa Pham on 09/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

public extension Element {

  public func children(predicate: ((Element, Int) -> Bool)? = nil) -> [Element] {
    var elements = [Element]()
    var cursor = self.cNode.pointee.children
    var index = 0

    while cursor != nil {
      if cursor!.pointee.type == XML_ELEMENT_NODE {
        let element = Element(node: cursor!)
        if let predicate = predicate {
          if predicate(element, index) {
            elements.append(element)
          }
        } else {
          elements.append(element)
        }

        index += 1
      }

      cursor = cursor?.pointee.next
    }

    return elements
  }

  public func children(name: String) -> [Element] {
    return children { element, index in
      return element.name == name
    }
  }

  public func children(indexes: [Int]) -> [Element] {
    return children { element, index in
      return indexes.contains(index)
    }
  }

  public func child(index: Int) -> Element? {
    return children(indexes: [index]).first
  }

  public func firstChild(name: String) -> Element? {
    return children(name: name).first
  }
}
