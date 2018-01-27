//
//  Array+DAG.swift
//  SwiftDAG
//
//  Created by Nicola Ferruzzi on 27/01/2018.
//  Copyright © 2018 Nicola Ferruzzi. All rights reserved.
//

import Foundation

public class DaggableArray<Element: Node> {
    private var array: Array<Element>
    private var parent: Node

    init(parent: Node, array: Array<Element>) {
        self.parent = parent
        self.array = array
    }

    public func append(_ newElement: Element) throws {
        try parent.addLink(to: newElement)
        array.append(newElement)
    }

    public func insert(_ newElement: Element, at i: Int) throws {
        try parent.addLink(to: newElement)
        array.insert(newElement, at: i)
    }

    public func remove(at position: Int) throws -> Element {
        let node = array.remove(at: position)
        try parent.removeLink(to: node)
        return node
    }
}

extension Array {
    func dag<Element>(_ parent: Node) -> DaggableArray<Element> {
        return DaggableArray<Element>.init(parent: parent, array: self as! Array<Element>)
    }
}
