//
//  Tests.swift
//  Reindeer
//
//  Created by Khoa Pham on 09/10/2016.
//  Copyright © 2016 Khoa Pham. All rights reserved.
//

import XCTest
import Reindeer

class Tests: XCTestCase {

  func test1() {
    let data = Utils.load(fileName: "test1")
    let document = try! Document(data: data)
  }

  func test2() {
    let data = Utils.load(fileName: "test2")
    let document = try! Document(data: data)
  }

}
