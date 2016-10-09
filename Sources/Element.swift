//
//  Element.swift
//  Reindeer
//
//  Created by Khoa Pham on 08/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

open class Element {

  let cNode: xmlNodePtr

  // MARK: - Initialization

  public init(node: xmlNodePtr) {
    self.cNode = node
  }

  // MARK: - Info

  public lazy var ns: String? = {
    return self.cNode.pointee.ns.toString()
  }()

  public lazy var prefix: String? = {
    return self.cNode.pointee.ns.pointee.prefix.toString()
  }()

  public lazy var name: String? = {
    return self.cNode.pointee.name.toString()
  }()

  public lazy var line: Int? = {
    return xmlGetLineNo(self.cNode)
  }()

  public lazy var parent: Element = {
    return Element(node: self.cNode.pointee.parent)
  }()

  public lazy var content: String? = {
    return xmlNodeGetContent(self.cNode).toString()
  }()

  public lazy var nextSibing: Element = {
    return Element(node: self.cNode.pointee.next)
  }()

  public lazy var previousSibing: Element = {
    return Element(node: self.cNode.pointee.prev)
  }()

  public lazy var attributes: [String: String] = {
    var dict: [String: String] = [:]

    var property = self.cNode.pointee.properties
    while property != nil {
      if let property = property, let name = property.pointee.name.toString() {
        let value = xmlGetProp(self.cNode, property.pointee.name).toString()
        dict[name] = value
      }

      property = property?.pointee.next
    }

    return dict
  }()

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
