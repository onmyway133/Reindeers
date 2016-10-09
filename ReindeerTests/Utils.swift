//
//  Utils.swift
//  Reindeer
//
//  Created by Khoa Pham on 09/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import Foundation

class Utils {

  static func load(fileName: String) -> Data {
    let bundle = Bundle(for: self)
    let path = bundle.path(forResource: fileName, ofType: "xml")

    return try! Data(contentsOf: URL(fileURLWithPath: path!))
  }
}
