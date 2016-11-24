//
//  Extensions.swift
//  Reindeer
//
//  Created by Khoa Pham on 09/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation

extension UnsafePointer {

  func toString() -> String? {
    return String(validatingUTF8: UnsafeRawPointer(self).assumingMemoryBound(to: Int8.self))
  }
}

extension UnsafeMutablePointer {

  func toString() -> String? {
    return String(validatingUTF8: UnsafeRawPointer(self).assumingMemoryBound(to: Int8.self))
  }
}

extension String {

  func toPointer() -> UnsafePointer<UInt8>? {
    guard let data = self.data(using: String.Encoding.utf8) else { return nil }

    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
    let stream = OutputStream(toBuffer: buffer, capacity: data.count)

    stream.open()
    data.withUnsafeBytes({ (p: UnsafePointer<UInt8>) -> Void in
      stream.write(p, maxLength: data.count)
    })

    stream.close()

    return UnsafePointer<UInt8>(buffer)
  }
}
