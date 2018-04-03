//
//  XPathAware.swift
//  Reindeer
//
//  Created by Khoa Pham on 09/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

public extension Element {

  func elements(XPath: String, namespace: String? = nil, predicate: ((Element) -> Bool)? = nil) -> [Element] {
    guard let cXPath = cXPathObject(XPath: XPath, namespace: namespace)
    else {
      return []
    }

    let indexes = Array(0..<Int(cXPath.pointee.nodesetval.pointee.nodeNr))

    return indexes.compactMap { index in
      guard index < Int(cXPath.pointee.nodesetval.pointee.nodeNr)
      else {
        return nil
      }

      if let cFoundNode = cXPath.pointee.nodesetval.pointee.nodeTab[index] {
        let element = Element(node: cFoundNode)
        if let predicate = predicate {
          return predicate(element) ? element : nil
        } else {
          return element
        }
      } else {
        return nil
      }
    }
  }

  func cXPathObject(XPath: String, namespace: String? = nil) -> xmlXPathObjectPtr? {
    guard let context = xmlXPathNewContext(self.cNode.pointee.doc)
      else {
        return nil
    }

    context.pointee.node = self.cNode

    // https://github.com/mattt/Ono/blob/master/Source/ONOXMLDocument.m#L851
    // Due to a bug in libxml2, namespaces may not appear in `cNode->ns`.
    // As a workaround, `cNode->nsDef` is recursed to explicitly register namespaces.

    var node = self.cNode
    while node.pointee.parent != nil {
      var ns = node.pointee.nsDef
      while ns != nil {
        if let href = ns?.pointee.href,
          let prefix = ns?.pointee.prefix ?? namespace?.toPointer() {
          xmlXPathRegisterNs(context, prefix, href)
        }

        ns = ns?.pointee.next
      }

      node = node.pointee.parent
    }

    let xmlXPath = xmlXPathEvalExpression(XPath, context)
    xmlXPathFreeContext(context)
    
    return xmlXPath
  }

}
