// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
//
// RUN: %target-run-simple-swift
// REQUIRES: executable_test
// REQUIRES: objc_interop

import Foundation
import CoreFoundation

#if FOUNDATION_XCTEST
import XCTest
class TestPersonNameComponentsSuper : XCTestCase { }
#else
import StdlibUnittest
class TestPersonNameComponentsSuper { }
#endif

class TestPersonNameComponents : TestPersonNameComponentsSuper {
    @available(OSX 10.11, iOS 9.0, *)
    func makePersonNameComponents(givenName: String, familyName: String) -> PersonNameComponents {
        var result = PersonNameComponents()
        result.givenName = givenName
        result.familyName = familyName
        return result
    }
    func test_AnyHashableContainingPersonNameComponents() {
        if #available(OSX 10.11, iOS 9.0, *) {
            let values: [PersonNameComponents] = [
                makePersonNameComponents(givenName: "Kevin", familyName: "Frank"),
                makePersonNameComponents(givenName: "John", familyName: "Appleseed"),
                makePersonNameComponents(givenName: "John", familyName: "Appleseed"),
            ]
            let anyHashables = values.map(AnyHashable.init)
            expectEqual("PersonNameComponents", String(describing: anyHashables[0].base.dynamicType))
            expectEqual("PersonNameComponents", String(describing: anyHashables[1].base.dynamicType))
            expectEqual("PersonNameComponents", String(describing: anyHashables[2].base.dynamicType))
            expectNotEqual(anyHashables[0], anyHashables[1])
            expectEqual(anyHashables[1], anyHashables[2])
        }
    }

    @available(OSX 10.11, iOS 9.0, *)
    func makeNSPersonNameComponents(givenName: String, familyName: String) -> NSPersonNameComponents {
        let result = NSPersonNameComponents()
        result.givenName = givenName
        result.familyName = familyName
        return result
    }

    func test_AnyHashableCreatedFromNSPersonNameComponents() {
        if #available(OSX 10.11, iOS 9.0, *) {
            let values: [NSPersonNameComponents] = [
                makeNSPersonNameComponents(givenName: "Kevin", familyName: "Frank"),
                makeNSPersonNameComponents(givenName: "John", familyName: "Appleseed"),
                makeNSPersonNameComponents(givenName: "John", familyName: "Appleseed"),
            ]
            let anyHashables = values.map(AnyHashable.init)
            expectEqual("PersonNameComponents", String(describing: anyHashables[0].base.dynamicType))
            expectEqual("PersonNameComponents", String(describing: anyHashables[1].base.dynamicType))
            expectEqual("PersonNameComponents", String(describing: anyHashables[2].base.dynamicType))
            expectNotEqual(anyHashables[0], anyHashables[1])
            expectEqual(anyHashables[1], anyHashables[2])
        }
    }
}

#if !FOUNDATION_XCTEST
var PersonNameComponentsTests = TestSuite("TestPersonNameComponents")
PersonNameComponentsTests.test("test_AnyHashableContainingPersonNameComponents") { TestPersonNameComponents().test_AnyHashableContainingPersonNameComponents() }
PersonNameComponentsTests.test("test_AnyHashableCreatedFromNSPersonNameComponents") { TestPersonNameComponents().test_AnyHashableCreatedFromNSPersonNameComponents() }
runAllTests()
#endif
