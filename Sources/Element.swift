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

  // MARK: - Initialization

  init(node: xmlNodePtr) {
    self.xmlNode = node
  }
}
