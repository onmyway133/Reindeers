//
//  Element.swift
//  Reindeer
//
//  Created by Khoa Pham on 08/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

open class Element: Equatable {

  let cNode: xmlNodePtr

  // MARK: - Initialization

  public init(node: xmlNodePtr) {
    self.cNode = node
  }

  // MARK: - Info

  public lazy var ns: String? = {
    return self.cNode.pointee.ns != nil ? self.cNode.pointee.ns.toString() : nil
  }()

  public lazy var prefix: String? = {
    return self.cNode.pointee.ns != nil ? self.cNode.pointee.ns.pointee.prefix.toString() : nil
  }()

  public lazy var name: String? = {
    return self.cNode.pointee.name != nil ? self.cNode.pointee.name.toString() : nil
  }()

  public lazy var line: Int? = {
    return xmlGetLineNo(self.cNode)
  }()

  public lazy var parent: Element? = {
    if let cParent = self.cNode.pointee.parent {
      return Element(node: cParent)
    }

    return nil
  }()

  public var content: String? {
    return xmlNodeGetContent(self.cNode).toString()
  }

  public lazy var nextSibling: Element? = {
    if let cSibling = self.cNode.pointee.next {
      return Element(node: cSibling)
    }

    return nil
  }()

  public lazy var previousSibling: Element? = {
    if let cSibling = self.cNode.pointee.prev {
      return Element(node: cSibling)
    }

    return nil
  }()

  public var attributes: [String: String] {
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
  }
}

public func == (left: Element, right: Element) -> Bool {
  return left.cNode == right.cNode
}
