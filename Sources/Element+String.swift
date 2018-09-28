//
//  Element+String.swift
//  Reindeers
//
//  Created by khoa on 28.09.2018.
//  Copyright © 2018 Khoa Pham. All rights reserved.
//

import Foundation
import Clibxml2

public extension Element {
  public func toXMLString() -> String {
    let openTag = "<\(name ?? "") \(toAttributeString()) >"

    let between: String
    if children().isEmpty {
      between = content ?? ""
    } else {
      between = children().map({ $0.toXMLString() }).joined()
    }

    let endTag = "</\(name ?? "")>"

    return openTag + between + endTag
  }

  public func toAttributeString() -> String {
    return attributes
      .map({ (key, value) in
        return "\(key)=\"\(value)\""
      })
      .joined(separator: " ")
  }
}
