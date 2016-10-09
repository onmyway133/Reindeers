//
//  Element.swift
//  Reindeer
//
//  Created by Khoa Pham on 08/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

class Element {

  let xmlNode: xmlNodePtr
  let xmlDocument: xmlDocPtr

  // MARK: - Initialization

  init(node: xmlNodePtr, document: xmlDocPtr) {
    self.xmlNode = node
    self.xmlDocument = document
  }

  // MARK: - Info

  lazy var ns: String? = {
    return self.xmlNode.pointee.ns.toString()
  }()

  lazy var prefix: String? = {
    return self.xmlNode.pointee.ns.pointee.prefix.toString()
  }()

  lazy var name: String? = {
    return self.xmlNode.pointee.name.toString()
  }()

  lazy var line: Int? = {
    return xmlGetLineNo(self.xmlNode)
  }()

  lazy var parent: Element = {
    return Element(node: self.xmlNode.pointee.parent, document: self.xmlDocument)
  }()

  lazy var content: String? = {
    return xmlNodeGetContent(self.xmlNode).toString()
  }()

  lazy var nextSibing: Element = {
    return Element(node: self.xmlNode.pointee.next, document: self.xmlDocument)
  }()

  lazy var previousSibing: Element = {
    return Element(node: self.xmlNode.pointee.prev, document: self.xmlDocument)
  }()

  func children(predicate: (Element, Int) -> Bool) -> [Element] {
    var elements = [Element]()
    var cursor = self.xmlNode.pointee.children
    var index = 0

    while cursor != nil {
      if let cursor = cursor, cursor.pointee.type == XML_ELEMENT_NODE {
        let element = Element(node: cursor, document: self.xmlDocument)
        if predicate(element, index) {
          elements.append(element)
        }
      }

      index += 1
      cursor = cursor?.pointee.next
    }

    return elements
  }

  func children(name: String) -> [Element] {
    return children { element, index in
      return element.name == name
    }
  }

  func children(indexes: [Int]) -> [Element] {
    return children { element, index in
      return indexes.contains(index)
    }
  }
}
