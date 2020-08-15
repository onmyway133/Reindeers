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

extension Data {

  // With help from Michael Tsai
  // https://mjtsai.com/blog/2019/03/27/swift-5-released/
    func withUnsafePointer<ResultType, ContentType: BinaryInteger>(_ body: (UnsafePointer<ContentType>) throws -> ResultType) rethrows -> ResultType {
    return try self.withUnsafeBytes { (rawBufferPointer: UnsafeRawBufferPointer) -> ResultType in
      let unsafeBufferPointer = rawBufferPointer.bindMemory(to: ContentType.self)
      guard let unsafePointer = unsafeBufferPointer.baseAddress else {
        var int: ContentType = 0
        return try body(&int)
      }
      return try body(unsafePointer)
    }
  }
}

extension String {

  func toPointer() -> UnsafePointer<UInt8>? {
    guard let data = self.data(using: String.Encoding.utf8) else { return nil }

    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: data.count)
    let stream = OutputStream(toBuffer: buffer, capacity: data.count)

    stream.open()
    data.withUnsafePointer({ (p: UnsafePointer<UInt8>) -> Void in
      stream.write(p, maxLength: data.count)
    })

    stream.close()

    return UnsafePointer<UInt8>(buffer)
  }
}
