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

  var xmlNode: xmlNodePtr { get }
}

extension XPathAware {
  
  func xmlXPathObject(XPath: String) -> xmlXPathObjectPtr? {
    guard let context = xmlXPathNewContext(self.xmlNode.pointee.doc)
      else {
        return nil
    }

    context.pointee.node = self.xmlNode

    // Due to a bug in libxml2, namespaces may not appear in `xmlNode->ns`.
    // As a workaround, `xmlNode->nsDef` is recursed to explicitly register namespaces.

    var node = self.xmlNode
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
