//
//  Extensions.swift
//  Reindeer
//
//  Created by Khoa Pham on 09/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation

extension UnsafeMutablePointer {

  func toString() -> String? {
    return String(validatingUTF8: UnsafeRawPointer(self).assumingMemoryBound(to: Int8.self))
  }
}
