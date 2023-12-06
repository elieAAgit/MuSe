//
//  HistoryModelTests.swift
//  MuSeTests
//
//  Created by Elie Arquier on 06/12/2023.
//

import XCTest
@testable import MuSe

class HistoryModelTests: XCTestCase {
    private var mockNav = MockNavigationController()
    private var coordinator: HistoryCoordinator!
    private var historyModel: HistoryViewModel!
    private var coreDataStack: MockCoreDataStack!

    // Fake object with history = true
    var title = "title"
    var detail = "detail"
    var category = Category(title: "Musée", id: "Museum")
    var longitude = 1.9
    var latitude = 47.9167
    var favorite: Bool = false
    var history: Bool = true
    var adress = "adress"
    var opening = "12h-18h"
    var phone = "01 75 01 02 03"
    var internet = "https://openclassrooms.com"
    var descript = "description"

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coordinator = HistoryCoordinator(navigationController: mockNav)
        historyModel = HistoryViewModel(coordinator: coordinator)
        
        coreDataStack = MockCoreDataStack(name: "MuSe")
        historyModel.placeManager = PlaceManager(context: coreDataStack.viewContext)
    }

    override func tearDown() {
        super.tearDown()
        historyModel.placeManager = nil
        coreDataStack = nil
    }

    //MARK: - Tests

    func testTableHasEntry() {
        // Given
        historyModel.placeManager?.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: favorite, history: history, adress: adress, opening: opening, phone: phone, internet: internet, description: descript)

        // When
        let hasEntry = historyModel.tableHasEntry()

        // Then
        XCTAssertTrue(hasEntry)
    }

    func testNumberOfRows() {
        // Given
        historyModel.placeManager?.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: favorite, history: history, adress: adress, opening: opening, phone: phone, internet: internet, description: descript)

        // When
        let numberOfRows = historyModel.numberOfRowsInSection()

        // Then
        XCTAssertEqual(historyModel.placeManager?.fetchedResultsController.count, 1)
        XCTAssertEqual(numberOfRows, 1)
    }

    func testDataForCell_WhenDataAreFound_theAnArrayOfPlacesIsCreated() {
        // Given
        historyModel.placeManager?.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: favorite, history: history, adress: adress, opening: opening, phone: phone, internet: internet, description: descript)

        // When
        let places = historyModel.dataForCell()
        guard let place = places?[0] else { return }

        // Then
        XCTAssertEqual(place.title, title)
    }

    func testDeletingRow_whenARowIsDeleted_thenThePlaceFavoriteIsFalse() {
        // Given
        historyModel.placeManager?.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: favorite, history: history, adress: adress, opening: opening, phone: phone, internet: internet, description: descript)

        // When
        guard let place = historyModel.placeManager?.fetchedResultsController[0] else { return }

        XCTAssertEqual(place.history, true)
        historyModel.deletingRow(place)

        // Then
        XCTAssertEqual(place.history, false)
    }
}
