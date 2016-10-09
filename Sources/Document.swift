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

  convenience init(data: Data) throws {
    let bytes = data.withUnsafeBytes {
      [Int8](UnsafeBufferPointer(start: $0, count: data.count))
    }

    try self.init(bytes: bytes)
  }

  convenience init(nsData: NSData) throws {
    var bytes = [UInt8](repeatElement(0, count: nsData.length))
    nsData.getBytes(&bytes, length:bytes.count * MemoryLayout<UInt8>.size)
    let data = Data(bytes: bytes)

    try self.init(data: data)
  }

  init(bytes: [Int8]) throws {
    let options = Int32(XML_PARSE_NOWARNING.rawValue | XML_PARSE_NOERROR.rawValue | XML_PARSE_RECOVER.rawValue)
    guard let document = xmlReadMemory(bytes, Int32(bytes.count), "", nil, options)
    else {
      throw InternalError.lastError()
    }

    self.xmlDocument = document
  }
}
