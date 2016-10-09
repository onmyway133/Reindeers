//
//  Error.swift
//  Reindeer
//
//  Created by Khoa Pham on 08/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

enum InternalError: Error {

  case unknown
  case parse(message: String, code: Int)

  static func lastError() -> InternalError {
    guard let pointer = xmlGetLastError()
    else {
      return .unknown
    }

    let message = pointer.pointee.message.toString() ?? ""
    let code = Int(pointer.pointee.code)

    return .parse(message: message, code: code)
  }
}
