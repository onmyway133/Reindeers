//
//  Document.swift
//  Reindeer
//
//  Created by Khoa Pham on 08/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

class Document {

  let xmlDocument: xmlDocPtr

  init(data: NSData, encoding: String.Encoding = .utf8) throws {
    let options = Int32(XML_PARSE_NOWARNING.rawValue | XML_PARSE_NOERROR.rawValue | XML_PARSE_RECOVER.rawValue)
    xmlDocument = xmlReadMemory(nil, Int32(data.length), "", nil, options)
  }
}
