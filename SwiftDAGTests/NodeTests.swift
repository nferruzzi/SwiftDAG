//
//  NodeTests.swift
//  SwiftDAG
//
//  Created by Nicola Ferruzzi on 25/01/2018.
//  Copyright © 2018 Nicola Ferruzzi. All rights reserved.
//

import XCTest
@testable import SwiftDAG

class NodeTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConnections() {
        let v = View()
        let c = View()

        XCTAssert(v.links.count == 0)
        XCTAssert(v.innerLinks.count == 0)

        v.children = c
        XCTAssert(v.links.count == 1)
        XCTAssert(v.innerLinks.count == 0)
        XCTAssert(c.innerLinks.count == 1)

        v.children = nil
        XCTAssert(v.links.count == 0)
        XCTAssert(c.innerLinks.count == 0)
    }

    func testExample() {
        let v = View()
        let l = Label()
        l.text = Text()
        l.color = Color()
        v.children = l
        XCTAssert(v.topologicalOrder().count == 4)
        v.children = nil
        XCTAssert(v.topologicalOrder().count == 1)
    }

    func testEdge() {
        let a = EdgeTest()
        let b = EdgeTest()
        try? a.other.connect(to: b)
        XCTAssert(a.other.child === b)
        XCTAssert(a.label.child == nil)
    }

    func testEdgeOperators() {
        let a = EdgeTest()
        let b = EdgeTest()
        try? a.other <= b
        XCTAssert(a.other^ === b)
    }

    func testEdgeArray() {
        let a = EdgeArrayTest()
        for c in 0..<10 {
            let e = EdgeTest()
            try? a.others.append(e)
            XCTAssert(a.links.count == c + 1)
            XCTAssert(a.others.childs.count == c + 1)
            XCTAssert(a.others.childs[c] === e)
        }
    }

    func testEdgeArraySpam() {
        let a = EdgeArrayTest()
        let e = EdgeTest()
        for c in 0..<10 {
            try! a.others.append(e)
            XCTAssertEqual(a.links.count, 1)
            XCTAssertEqual(a.others.childs.count, c + 1)
        }
    }

    func testLoop() {
        let a = Node()
        let b = Node()
        try! a.addLink(to: b)
        XCTAssertThrowsError(try b.addLink(to: a))
    }

    func testLoop2() {
        let a = Node()
        let b = Node()
        let c = Node()
        try! a.addLink(to: b)
        try! b.addLink(to: c)
        XCTAssertThrowsError(try c.addLink(to: a))
    }

    func testLoopArray() {
        let a = EdgeArrayTest()
        let b = EdgeTest()
        try! a.others.append(b)
        XCTAssertThrowsError(try b.array.connect(to: a))
    }

    func testLoopEdge() {
        let a = EdgeTest()
        let b = EdgeTest()
        try! a.other.connect(to: b)
        XCTAssertThrowsError(try b.other.connect(to: a))
    }

    func testLoopEdges() {
        let a = EdgeTest()
        let b = EdgeTest()
        let c = EdgeArrayTest()
        try! a.other.connect(to: b)
        try! b.array.connect(to: c)
        XCTAssertThrowsError(try c.others.append(a))
    }

    func testDictionary() {
        let a = EdgeDictionaryTest()
        let b = EdgeTest()
        XCTAssertEqual(a.links.count, 0)
        a.map[1] = b
        XCTAssertEqual(a.links.count, 1)
        a.map[1] = b
        XCTAssertEqual(a.links.count, 1)
        XCTAssertEqual(a.map.childs.count, 1)
        a.map[2] = b
        XCTAssertEqual(a.links.count, 1)
        XCTAssertEqual(a.map.childs.count, 2)
        a.map[2] = nil
        XCTAssertEqual(a.links.count, 1)
        XCTAssertEqual(a.map.childs.count, 1)
        a.map[1] = nil
        XCTAssertEqual(a.links.count, 0)
        XCTAssertEqual(a.map.childs.count, 0)
    }

    func testDictionaryLoop() {
        let a = EdgeDictionaryTest()
        let b = EdgeTest()
        a.map[1] = b
        XCTAssertThrowsError(try b.dummy.connect(to: a))
    }

    func testDictionaryDefault() {
        let a = EdgeDictionaryTest()
        let b = EdgeTest()
        let value = a.map[1, default: b]
        XCTAssertTrue(value === b)
        XCTAssertEqual(a.links.count, 1)
        XCTAssertEqual(a.map.childs.count, 1)
    }

    func testDictionaryDefault2() {
        let a = EdgeDictionaryTest()
        let b = EdgeTest()
        let c = EdgeTest()
        a.map[1, default: b] = c
        XCTAssertTrue(a.map.childs[1] === c)
        XCTAssertEqual(a.links.count, 1)
        XCTAssertEqual(a.map.childs.count, 1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

