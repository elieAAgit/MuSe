//
//  MapModelTests.swift
//  MuSeTests
//
//  Created by Elie Arquier on 06/12/2023.
//

import XCTest
@testable import MuSe

class MapModelTests: XCTestCase {
    private var mockNav = MockNavigationController()
    private var coordinator: MapCoordinator!
    private var mapModel: MapViewModel!

    // properties tested
    private var selectors = [String]()

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coordinator = MapCoordinator(navigationController: mockNav)
        mapModel = MapViewModel(coordinator: coordinator, selectors: selectors)
    }

    // MARK: - Tests

    func testAddMuseum_WhenASelectorIsAdd_ThenSelectorIsAddedToSelectorsAndAValueIsReturn() {
        // categories.id= ["Museum", "Theatre", "Garden"]
        //                  tag.0      tag.1      tag.2

        // Given
        mapModel.selectors = ["Theatre"] // 1 item

        // When
        let value = mapModel.addSelector(tag: 0) // Garden

        // Then
        XCTAssertEqual(mapModel.selectors.count, 2)
        XCTAssertEqual(mapModel.selectors[0], "Theatre")
        XCTAssertEqual(mapModel.selectors[1], "Museum")
        XCTAssertEqual(value, "Museum")
    }

    func testAddTheatre_WhenASelectorIsAdd_ThenSelectorIsAddedToSelectorsAndAValueIsReturn() {
        // categories.id= ["Museum", "Theatre", "Garden"]
        //                  tag.0      tag.1      tag.2

        // Given
        mapModel.selectors = ["Museum"] // 1 item

        // When
        let value = mapModel.addSelector(tag: 1) // Theatre

        // Then
        XCTAssertEqual(mapModel.selectors.count, 2)
        XCTAssertEqual(mapModel.selectors[0], "Museum")
        XCTAssertEqual(mapModel.selectors[1], "Theatre")
        XCTAssertEqual(value, "Theatre")
    }

    func testAddGarden_WhenASelectorIsAdd_ThenSelectorIsAddedToSelectorsAndAValueIsReturn() {
        // categories.id= ["Museum", "Theatre", "Garden"]
        //                  tag.0      tag.1      tag.2

        // Given
        mapModel.selectors = ["Museum"] // 1 item

        // When
        let value = mapModel.addSelector(tag: 2) // Garden

        // Then
        XCTAssertEqual(mapModel.selectors.count, 2)
        XCTAssertEqual(mapModel.selectors[0], "Museum")
        XCTAssertEqual(mapModel.selectors[1], "Garden")
        XCTAssertEqual(value, "Garden")
    }

    func testRemoveMuseum_WhenASelectorIsRemove_ThenSelectorIsRemovedToSelectorsAndAValueIsReturn() {
        // categories.id= ["Museum", "Theatre", "Garden"]
        //                  tag.0      tag.1      tag.2

        // Given
        mapModel.selectors = ["Museum", "Theatre"] // 2 items

        // When
        let value = mapModel.removeSelector(tag: 0) // Museum

        // Then
        XCTAssertEqual(mapModel.selectors.count, 1)
        XCTAssertEqual(mapModel.selectors[0], "Theatre")
        XCTAssertEqual(value, "Museum")
    }

    func testRemoveTheatre_WhenASelectorIsRemove_ThenSelectorIsRemovedToSelectorsAndAValueIsReturn() {
        // categories.id= ["Museum", "Theatre", "Garden"]
        //                  tag.0      tag.1      tag.2

        // Given
        mapModel.selectors = ["Museum", "Theatre"] // 2 items

        // When
        let value = mapModel.removeSelector(tag: 1) // Theatre

        // Then
        XCTAssertEqual(mapModel.selectors.count, 1)
        XCTAssertEqual(mapModel.selectors[0], "Museum")
        XCTAssertEqual(value, "Theatre")
    }

    func testRemoveGarden_WhenASelectorIsRemove_ThenSelectorIsRemovedToSelectorsAndAValueIsReturn() {
        // categories.id= ["Museum", "Theatre", "Garden"]
        //                  tag.0      tag.1      tag.2

        // Given
        mapModel.selectors = ["Theatre", "Garden"] // 2 items

        // When
        let value = mapModel.removeSelector(tag: 2) // Garden

        // Then
        XCTAssertEqual(mapModel.selectors.count, 1)
        XCTAssertEqual(mapModel.selectors[0], "Theatre")
        XCTAssertEqual(value, "Garden")
    }
}
