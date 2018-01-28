# SwiftDAG

##### Warning: API IS NOT STABLE, still evaluating different approaches.

### How a DAG can be used to represent data structure relations

DAG is the acronym for [Directed Acyclic Graph](https://en.wikipedia.org/wiki/Directed_acyclic_graph) which is basically a graph without closed loops made of 'single way' directed connections. It has a lot of pratical applications, usually related to shortest-path or topological ordering.

While the basic algorithms and the same `SwiftDAG` is modelled to provide a simple interface to represent data structure relations in memory, where each `Node` (or vertex) is an object and each `Edge` (or connection) is a relation between nodes. 

Example:
```swift
class UFrame: Node {
    var size: CGRect?
    var origin: CGPoint?
}

class UView: Node {
    lazy var subviews = EdgeArray<UView>(parent: self)
    lazy var frame = Edge<UFrame>(parent: self)
    var backgroundColor = UIColor.black
}
```

`UView` is connected to `UFrame` via the `Edge` variable `frame` and to multiple `subviews` via the `EdgeArray` variable `subviews`. 

The connections are created ar run-time. 

Example, explicit:
```swift
    let view = UView()
    let frame = UFrame()
    view.frame.connect(to: frame)
```

Example, operator:
```swift
    let view = UView()
    let frame = UFrame()
    view.frame <= frame
```

Pratically speaking the base `Node` class contains the list of connetions and the `Edge` classes helps to link/unlink the Nodes

By storing the conections from a `Node` to its siblings it's possible to traverse the tree to create a `Topological Order`

```swift
    print(view.topologicalOrder())

    [UFrame(uuid: 140418024708768), UView(uuid: 140418022602544)]
```

### Documentation TODO:
1. try/catch: exceptions are used to avoid closed loops and integrity checks
1. behind the scens, inner links and outer links
1. direct graph manipulation
1. simple queries
1. serialization/deserialization
1. PRO users: sourcery based API

### Things to TODO:
1. Integration with CocoaPods / Carthage 
1. `JSON` serialization/deserialization using the `hash` 
1. more examples and more tests
1. travis integration


### How to generate Examples interface
`./Sourcery --templates SwiftDAG/Templates --sources . --output SwiftDAGTests --watch --verbose`
