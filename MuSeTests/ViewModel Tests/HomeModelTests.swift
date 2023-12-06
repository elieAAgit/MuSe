//
//  HomeModelTests.swift
//  MuSeTests
//
//  Created by Elie Arquier on 05/12/2023.
//

import XCTest
@testable import MuSe

class HomeModelTests: XCTestCase {
    private var mockNav = MockNavigationController()
    private var coordinator: HomeCoordinator!
    private var homeModel: HomeViewModel!

    // properties tested
    private var categories = [1, 2, 3]
    
    let numberOfSections = 1
    var numberOfRows: Int {
        return categories.count
    }

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coordinator = HomeCoordinator(navigationController: mockNav)
        homeModel = HomeViewModel(coordinator: coordinator)
    }

    //MARK: - Tests

    func testNumberOfRows() {
        XCTAssertEqual(numberOfRows, 3)
    }

    func testAddOrRemove_WhenIsInTheSelectors_ThenSelectorIsAdded() {
        // categories.id= ["Museum", "Theatre", "Garden"]

        // Given
        let selectors = ["Museum"] // 1 item

        // When
        homeModel.selectors = selectors
        homeModel.addOrRemoveItem(2)

        // Then
        XCTAssertEqual(homeModel.selectors.count, 2)
    }

    func testAddOrRemove_WhenSelectorIsInTheSelectors_ThenSelectorIsRemoved() {
        // categories.id= ["Museum", "Theatre", "Garden"]

        // Given
        let selectors = ["Museum", "Theatre", "Garden"] // 3 items

        // When
        homeModel.selectors = selectors
        homeModel.addOrRemoveItem(2) 

        // Then
        XCTAssertEqual(homeModel.selectors.count, 2)
    }
}
