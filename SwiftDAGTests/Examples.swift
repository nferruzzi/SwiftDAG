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

class Parent: Node {
    var _children: Children?
    var _childrens: [Children]?

    func add(children: Children) {
        try? _childrens?.dag(self).append(children)
    }
}

class Children: Node {
    var value: Int = 0
}