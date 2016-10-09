# Reindeer
xml in Swift

[![CI Status](http://img.shields.io/travis/onmyway133/Reindeer.svg?style=flat)](https://travis-ci.org/onmyway133/Reindeer)
[![Version](https://img.shields.io/cocoapods/v/Reindeer.svg?style=flat)](http://cocoadocs.org/docsets/Reindeer)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Reindeer.svg?style=flat)](http://cocoadocs.org/docsets/Reindeer)
[![Platform](https://img.shields.io/cocoapods/p/Reindeer.svg?style=flat)](http://cocoadocs.org/docsets/Reindeer)
![Swift](https://img.shields.io/badge/%20in-swift%203.0-orange.svg)

![](Screenshots/Banner.png)

## Description

- Use libxml2
- Based on https://github.com/mattt/Ono

## Usage

### XML, SVG, RSS

```xml
<html>
<body>

<h1>My first SVG</h1>

<svg width="100" height="100">
  <circle cx="50" cy="50" r="40" stroke="green" stroke-width="4" fill="yellow" />
</svg>

</body>
</html
```

```swift
let data = Utils.load(fileName: "test4", ext: "svg")
let document = try! Document(data: data)

document.rootElement.name
document.rootElement.children()

document.rootElement.elements(XPath: "//svg").first?.attributes["width"]
document.rootElement.elements(XPath: "//circle").first?.attributes["stroke"]
```

### HTML

```swift
let data = Utils.load(fileName: "test3", ext: "html")
let document = try? Document(data: data, kind: .html)

let body = document.rootElement.child(index: 1)
body?.elements(XPath: "//p").first?.content
```

### Query

- Get element info

```swift
let element = document.rootElement.child(index: 0)

element.name
element.ns
element.line
element.attributes
element.parent
element.nextSibling
element.previousSibling
```

- Get child elements

```swift
element.children { child, index in
  return child.name == "a"
}

element.children(name: "item")
```

- XPath

```swift
let body = document.rootElement.firstChild(name: "body")
body?.elements(XPath: "//a").first?.attributes["href"]
```

## Installation

**Reindeer** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Reindeer'
```

**Reindeer** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "onmyway133/Reindeer"
```

**Reindeer** can also be installed manually. Just download and drop `Sources` folders in your project.

## Author

Khoa Pham, onmyway133@gmail.com

## Contributing

We would love you to contribute to **Reindeer**, check the [CONTRIBUTING](https://github.com/onmyway133/Reindeer/blob/master/CONTRIBUTING.md) file for more info.

## License

**Reindeer** is available under the MIT license. See the [LICENSE](https://github.com/onmyway133/Reindeer/blob/master/LICENSE.md) file for more info.
