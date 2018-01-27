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
        XCTAssert(v.linkEntranti.count == 0)

        v.children = c
        XCTAssert(v.links.count == 1)
        XCTAssert(v.linkEntranti.count == 0)
        XCTAssert(c.linkEntranti.count == 1)

        v.children = nil
        XCTAssert(v.links.count == 0)
        XCTAssert(c.linkEntranti.count == 0)
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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

