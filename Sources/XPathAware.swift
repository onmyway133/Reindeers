//
//  XPathAware.swift
//  Reindeer
//
//  Created by Khoa Pham on 09/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

protocol XPathAware {

  var cNode: xmlNodePtr { get }
}

extension XPathAware {

  func elements(XPath: String, indexes: [Int]) -> [Element] {
    guard let cXPath = cXPathObject(XPath: XPath)
    else {
      return []
    }

    var indexes = indexes
    if indexes.isEmpty {
      indexes = Array(0..<Int(cXPath.pointee.nodesetval.pointee.nodeNr))
    }

    return indexes.flatMap { index in
      if index < Int(cXPath.pointee.nodesetval.pointee.nodeNr) {
        if let cFoundNode = cXPath.pointee.nodesetval.pointee.nodeTab[index] {
          return Element(node: cFoundNode)
        }
      }

      return nil
    }
  }

  func cXPathObject(XPath: String) -> xmlXPathObjectPtr? {
    guard let context = xmlXPathNewContext(self.cNode.pointee.doc)
      else {
        return nil
    }

    context.pointee.node = self.cNode

    // Due to a bug in libxml2, namespaces may not appear in `cNode->ns`.
    // As a workaround, `cNode->nsDef` is recursed to explicitly register namespaces.

    var node = self.cNode
    while node.pointee.parent != nil {
      var ns = node.pointee.nsDef
      while ns != nil {
        let prefix = ns?.pointee.prefix

      }
    }

    let xmlXPath = xmlXPathEvalExpression(XPath, context)
    xmlXPathFreeContext(context)
    
    return xmlXPath
  }

}
