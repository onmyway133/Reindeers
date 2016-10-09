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
    // http://www.w3schools.com/xml/cd_catalog.xml
    let data = Utils.load(fileName: "test1", ext: "xml")
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

    XCTAssertEqual(document.rootElement.elements(XPath: "//TITLE").count, 26)
  }

  func test2() {
    // http://www.w3schools.com/xml/xml_rss.asp
    let data = Utils.load(fileName: "test2", ext: "xml")
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

    XCTAssertEqual(channel?.elements(XPath: "//item").count, 2)
  }

  func test3() {
    let data = Utils.load(fileName: "test3", ext: "html")
//    let document = try! Document(data: data)

  }

  func test4() {
    // http://www.w3schools.com/graphics/svg_intro.asp
    let data = Utils.load(fileName: "test4", ext: "svg")
    let document = try! Document(data: data)

    XCTAssertEqual(document.rootElement.name, "html")
    XCTAssertEqual(document.rootElement.children().count, 1)

    XCTAssertEqual(document.rootElement.elements(XPath: "//svg").first?.attributes["width"], "100")
    XCTAssertEqual(document.rootElement.elements(XPath: "//circle").first?.attributes["stroke"], "green")
  }

}
