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
}
