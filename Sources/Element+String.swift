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
  public func toXMLString(level: Int = 0) -> String {
    let openTag = "<\(name ?? "")\(toAttributeString())>"
    let indentation = Array(repeating: "  ", count: level).joined()

    let between: String
    if children().isEmpty {
      between = (content ?? "")
    } else {
      between = children().map({ $0.toXMLString(level: level + 1) }).joined()
    }

    let endTag = "</\(name ?? "")>"

    return indentation + openTag + "\n"
      + indentation + between + "\n"
      + indentation + endTag + "\n"
  }

  public func toAttributeString() -> String {
    if attributes.isEmpty {
      return ""
    } else {
      return " " + attributes
        .map({ (key, value) in
          return "\(key)=\"\(value)\""
        })
        .joined(separator: " ")
    }
  }
}
