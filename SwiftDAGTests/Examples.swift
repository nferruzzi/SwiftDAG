//
//  Examples.swift
//  SwiftDAGTests
//
//  Created by Nicola Ferruzzi on 27/01/2018.
//  Copyright © 2018 Nicola Ferruzzi. All rights reserved.
//

import Foundation
import SwiftDAG

class Color: Node {
    var color = "#000000"
}

class Text: Node {
    var text = "Label"
    var property: Int = 0
}

class View: Node {
    var _children: View?
}

class Label: View {
    var _color: Color?
    var _text: Text?
}

class EdgeTest: Node {
    lazy var other = Edge<EdgeTest>(parent: self)
    lazy var label = Edge<Label>(parent: self)
    lazy var array = Edge<EdgeArrayTest>(parent: self)
    lazy var dummy = Edge<Node>(parent: self)
}

class EdgeArrayTest: Node {
    lazy var others = EdgeArray<EdgeTest>(parent: self)
}

class EdgeDictionaryTest: Node {
    lazy var map = EdgeDictionary<Int, EdgeTest>(parent: self)
}


class Parent: Node {
    var _children: Children?
    var _childrens: [Children]?

    func add(children: Children) {
//        try? _childrens?.dag(self).append(children)
//        _childrens?.dag(self)
    }
}

class Children: Node {
    var value: Int = 0
}
