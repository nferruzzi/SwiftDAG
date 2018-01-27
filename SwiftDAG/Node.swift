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
    case WeakParentNotFound
}

//protocol Daggable: Hashable {
//    func addLink(to node: Any) throws
//    func removeLink(from node: Any)
//}

public class Node: NSObject {
//    private static var gids:Int = 0
//    private var UUID:Int = {
//        Node.gids += 1
//        return Node.gids
//    }()

    @objc var linkUscenti: [Node] = []
    @objc var linkEntranti = NSPointerArray.weakObjects()

    @objc func hasLink(from vertex: Node)  -> Bool {
        for v in linkEntranti.allObjects {
            if let v = v as? Node {
                if v === vertex { return true }
                if v.hasLink(from: vertex) == true { return true }
            }
        }
        return false
    }

    @objc func addLink(to node: Node) throws {
        // do not allow cyclic references
        if node === self { throw DAGError.AcyclicInvariant }
        if hasLink(from: node) { throw DAGError.AcyclicInvariant }
        linkUscenti.append(node)
        let w = Unmanaged.passUnretained(self).toOpaque()
        node.linkEntranti.addPointer(w)
    }

    @objc func removeLink(from node: Node) {
        guard let index = linkUscenti.index(of: node) else { return }
        linkUscenti.remove(at: index)
        let w = Unmanaged.passUnretained(self).toOpaque()
        let eindex = node.linkEntranti.index(ofAccessibilityElement: w)
        if eindex != NSNotFound {
            node.linkEntranti.removePointer(at: eindex)
        }
    }

    @objc func topologicalOrder() -> [Node] {
        var visited = Set<Node>()
        return depthFirst(visited: &visited)
    }

    func depthFirst(visited:inout Set<Node>) -> [Node] {
        var nodes:[Node] = []
        visited.insert(self)
        for v in linkUscenti {
            if !visited.contains(v) {
                nodes.append(contentsOf: v.depthFirst(visited: &visited))
            }
        }
        nodes.append(self)
        return nodes
    }

    func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }

    public override var debugDescription: String {
        return "\(typeName(self))(uuid: \(hash))"
    }
}

