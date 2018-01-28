//
//  Edge.swift
//  SwiftDAG
//
//  Created by Nicola Ferruzzi on 27/01/2018.
//  Copyright © 2018 Nicola Ferruzzi. All rights reserved.
//

import Foundation

postfix operator ^

class Edge<Element: Node> {
    unowned let parent: Node
    var child: Element?

    init(parent: Node) {
        self.parent = parent
    }

    init(parent: Node, child: Element) {
        self.parent = parent
        self.child = child
    }

    public func connect(to rhs: Element) throws {
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

class EdgeArray<Element: Node> {
    unowned let parent: Node
    private(set) var childs: Array<Element> = []

    init(parent: Node) {
        self.parent = parent
    }

    init(parent: Node, childs: Array<Element>) {
        self.parent = parent
        self.childs = childs
    }

    public func append(_ newElement: Element) throws {
        try parent.addLink(to: newElement)
        childs.append(newElement)
    }

    public func insert(_ newElement: Element, at i: Int) throws {
        try parent.addLink(to: newElement)
        childs.insert(newElement, at: i)
    }

    public func remove(at position: Int) throws -> Element {
        let node = childs.remove(at: position)
        try parent.removeLink(to: node)
        return node
    }
}

class EdgeDictionary<Key: Hashable, Value: Node> {
    unowned let parent: Node
    private(set) var childs: Dictionary<Key, Value> = [:]

    init(parent: Node) {
        self.parent = parent
    }

    init(parent: Node, childs: Dictionary<Key, Value>) {
        self.parent = parent
        self.childs = childs
    }

    public subscript(key: Key) -> Value? {
        get {
            return childs[key]
        }

        set {
            if let ov = childs[key] {
                try! parent.removeLink(to: ov)
                childs.removeValue(forKey: key)
            }
            if let newValue = newValue {
                try! parent.addLink(to: newValue)
                childs[key] = newValue
            }
        }
    }

    public subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value {
        get {
            if let ov = childs[key] {
                try! parent.removeLink(to: ov)
                childs.removeValue(forKey: key)
            }
            let nv = defaultValue()
            try! parent.addLink(to: nv)
            childs[key] = nv
            return nv
        }

        set {
            if let ov = childs[key] {
                try! parent.removeLink(to: ov)
                childs.removeValue(forKey: key)
            }
            try! parent.addLink(to: newValue)
            childs[key] = newValue
        }
    }

    public func removeValue(forKey key: Key) throws -> Value? {
        guard let value = childs.removeValue(forKey: key) else { return nil }
        try parent.removeLink(to: value)
        return value
    }
}
