//
//  Node.swift
//  SwiftDAG
//
//  Created by Nicola Ferruzzi on 25/01/2018.
//  Copyright © 2018 Nicola Ferruzzi. All rights reserved.
//

import Foundation


public enum DAGError: Error {
    case AcyclicInvariant
    case LinkNotFound
    case ParentLinkNotFound
}

private extension Dictionary where Key == Node, Value == Int {
    mutating func increase(key: Key) {
        let p = self[key, default: 0] + 1
        self[key] = p
    }

    mutating func decrease(key: Key) throws {
        let p = self[key, default: 0]
        switch p {
        case 0:
            throw DAGError.LinkNotFound
        case 1:
            removeValue(forKey: key)
        default:
            self[key] = p - 1
        }
    }
}

public class Node: NSObject {

    @objc var linkEntranti = NSPointerArray.weakObjects()
    @objc var links = [Node: Int]()

    @objc func hasLink(from vertex: Node) -> Bool {
        for v in links.keys {
            if v === vertex { return true }
            if v.hasLink(from: vertex) == true { return true }
        }
        return false
    }

    @objc func addLink(to node: Node) throws {
        if node === self { throw DAGError.AcyclicInvariant }
        if hasLink(from: node) { throw DAGError.AcyclicInvariant }
        links.increase(key: node)
        let w = Unmanaged.passUnretained(self).toOpaque()
        node.linkEntranti.addPointer(w)
    }

    @objc func removeLink(to node: Node) throws {
        for (index, k) in node.linkEntranti.allObjects.enumerated() {
            if let k = k as? Node, k === self {
                node.linkEntranti.removePointer(at: index)
                try links.decrease(key: node)
                return
            }
        }
        throw DAGError.ParentLinkNotFound
    }

    @objc func topologicalOrder() -> [Node] {
        var visited = Set<Node>()
        return depthFirst(visited: &visited)
    }

    func depthFirst(visited:inout Set<Node>) -> [Node] {
        var nodes:[Node] = []
        visited.insert(self)
        for v in links.keys {
            if !visited.contains(v) {
                nodes.append(contentsOf: v.depthFirst(visited: &visited))
            }
        }
        nodes.append(self)
        return nodes
    }

    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }

    public override var debugDescription: String {
        return "\(typeName(self))(uuid: \(hash))"
    }
}
