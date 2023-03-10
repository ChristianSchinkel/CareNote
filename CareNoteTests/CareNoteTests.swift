//
//  CareNoteTests.swift
//  CareNoteTests
//
//  Created by Christian Schinkel on 2022-07-10.
//

import XCTest
@testable import CareNote
import CoreData

class CareNoteTests: XCTestCase {
    
    var controller: PersistenceController!
    var context: NSManagedObjectContext {
        controller.container.viewContext
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // My code starts here:
        try super.setUpWithError()
        controller = PersistenceController.empty
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // My code starts here:
        try super.tearDownWithError()
        controller = nil
    }
    // This is a unit test for a function.
    func test_Add_Item() {
        let item = Item(context: context)
        
        XCTAssertNotNil(item.name_, "should have name")
        XCTAssertNotNil(item.timestamp_, "should have date")
    }
    func test_Fetch() {
        let context = PersistenceController.empty.container.viewContext
        // let item = Item(context: context)
        
        let request = Item.fetch()
        let items = try? context.fetch(request)
        
        XCTAssertTrue(items?.count ?? 0 > 0, "item was not fetched")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
