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

    XCTAssertEqual(document.version, "1.0")
    XCTAssertEqual(document.encoding, "UTF-8")

    XCTAssertEqual(document.rootElement.name, "CATALOG")

    XCTAssertEqual(document.rootElement.children().count, 3)
    XCTAssertEqual(document.rootElement.children(indexes: [1, 2, 3]).count, 3)
    XCTAssertEqual(document.rootElement.child(index: 2)!.name, "CD")

//    XCTAssertEqual(document.rootElement.child(index: 2)!.attributes["TITLE"], "Greatest Hits")
  }

  func test2() {
    let data = Utils.load(fileName: "test2")
    let document = try! Document(data: data)
  }

}
