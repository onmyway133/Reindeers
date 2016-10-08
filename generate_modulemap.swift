#!/usr/bin/env xcrun swift

import Foundation

let headers = [
  "libxml2/libxml/parser.h",
  "libxml2/libxml/HTMLparser.h",
  "libxml2/libxml/HTMLtree.h",
  "libxml2/libxml/xmlreader.h",
  "libxml2/libxml/xpath.h",
  "libxml2/libxml/xpathInternals.h",
]

let platforms = [
  "appletvos",
  "appletvsimulator",
  "iphoneos",
  "iphonesimulator",
  "macosx",
  "watchos",
  "watchsimulator"
]

func run() {
  let rootPath = ProcessInfo.processInfo.environment["PWD"]!
  let directories = try! FileManager.default.contentsOfDirectory(atPath: "\(rootPath)/Cocoapods")
  for directory in directories where directory.characters.first != "." {

    let includePath = getIncludePath(directory: directory)
    var content = "module Clibxml2 [system] {\n"

    for header in headers {
      content += "  header \"\(includePath)/\(header)\"\n"
    }

    content += "export *\n"
    content += "}"

    try? content.write(toFile: "\(rootPath)/Cocoapods/\(directory)/module.modulemap", atomically: true, encoding: .utf8)
  }
}

func getIncludePath(directory: String) -> String {
  switch directory {
  case "appletvos":
    return "/Applications/Xcode.app/Contents/Developer/Platforms/AppleTVOS.platform/Developer/SDKs/AppleTVOS.sdk/usr/include"
  case "appletvsimulator":
    return "/Applications/Xcode.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/SDKs/AppleTVSimulator.sdk/usr/include"
  case "iphoneos":
    return "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/usr/include"
  case "iphonesimulator":
    return "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/usr/include"
  case "macosx":
    return "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include"
  case "watchos":
    return "/Applications/Xcode.app/Contents/Developer/Platforms/WatchOS.platform/Developer/SDKs/WatchOS.sdk/usr/include"
  case "watchsimulator":
    return "/Applications/Xcode.app/Contents/Developer/Platforms/WatchSimulator.platform/Developer/SDKs/WatchSimulator.sdk/usr/include"
  default:
    return ""
  }
}

run()
