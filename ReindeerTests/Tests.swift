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

    XCTAssertEqual(document.rootElement.children().count, 26)
    XCTAssertEqual(document.rootElement.children(name: "CD").count, 26)
    XCTAssertEqual(document.rootElement.children(indexes: [0, 1, 2]).count, 3)
    XCTAssertEqual(document.rootElement.child(index: 2)!.name, "CD")

    let cd = document.rootElement.child(index: 2)
    XCTAssertEqual(cd?.child(index: 0)?.name, "TITLE")
    XCTAssertEqual(cd?.child(index: 0)?.content, "Greatest Hits")
    XCTAssertEqual(cd?.firstChild(name: "ARTIST")?.content, "Dolly Parton")
  }

  func test2() {
    let data = Utils.load(fileName: "test2")
    let document = try! Document(data: data)

    XCTAssertEqual(document.version, "1.0")
    XCTAssertEqual(document.encoding, "UTF-8")

    XCTAssertEqual(document.rootElement.name, "rss")
    XCTAssertEqual(document.rootElement.attributes["version"], "2.0")

    XCTAssertEqual(document.rootElement.children().count, 1)
    XCTAssertEqual(document.rootElement.children(indexes: [0, 1, 2]).count, 1)

    let channel = document.rootElement.child(index: 0)
    XCTAssertEqual(channel?.children().count, 5)
    XCTAssertEqual(channel?.children(name: "item").count, 2)
    XCTAssertEqual(channel?.child(index: 0)!.name, "title")
    XCTAssertEqual(channel?.child(index: 0)!.content, "W3Schools Home Page")
  }

}
