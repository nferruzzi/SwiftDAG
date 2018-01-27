//
//  Edge.swift
//  SwiftDAG
//
//  Created by Nicola Ferruzzi on 27/01/2018.
//  Copyright © 2018 Nicola Ferruzzi. All rights reserved.
//

import Foundation

postfix operator ^

struct Edge<Element: Node> {
    unowned let parent: Node
    var child: Element?

    init(parent: Node) {
        self.parent = parent
    }

    init(parent: Node, child: Element) {
        self.parent = parent
        self.child = child
    }

    mutating public func connect(to rhs: Element) throws {
        try parent.addLink(to: rhs)
        if let child = child {
            try parent.removeLink(to: child)
        }
        child = rhs
    }

    public static func <= (lhs: inout Edge<Element>, rhs: Element) throws {
        try lhs.parent.addLink(to: rhs)
        if let child = lhs.child {
            try lhs.parent.removeLink(to: child)
        }
        lhs.child = rhs
    }

    public static postfix func ^ (lhs: Edge<Element>) -> Element {
        return lhs.child!
    }
}

struct EdgeArray<Element: Node> {
    unowned let parent: Node
    private(set) var childs: Array<Element> = []

    init(parent: Node) {
        self.parent = parent
    }

    init(parent: Node, childs: Array<Element>) {
        self.parent = parent
        self.childs = childs
    }

    mutating public func append(_ newElement: Element) throws {
        try parent.addLink(to: newElement)
        childs.append(newElement)
    }

    mutating public func insert(_ newElement: Element, at i: Int) throws {
        try parent.addLink(to: newElement)
        childs.insert(newElement, at: i)
    }

    mutating public func remove(at position: Int) throws -> Element {
        let node = childs.remove(at: position)
        try parent.removeLink(to: node)
        return node
    }
}


