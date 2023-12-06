//
//  FavoritesModelTests.swift
//  MuSeTests
//
//  Created by Elie Arquier on 06/12/2023.
//
import XCTest
@testable import MuSe

class FavoritesModelTests: XCTestCase {
    private var mockNav = MockNavigationController()
    private var coordinator: FavoritesCoordinator!
    private var favoritesModel: TableViewModel!
    private var coreDataStack: MockCoreDataStack!

    // Fake object with history = true
    var title = "title"
    var detail = "detail"
    var category = Category(title: "Musée", id: "Museum")
    var longitude = 1.9
    var latitude = 47.9167
    var favorite: Bool = true
    var history: Bool = false
    var adress = "adress"
    var opening = "12h-18h"
    var phone = "01 75 01 02 03"
    var internet = "https://openclassrooms.com"
    var descript = "description"

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coordinator = FavoritesCoordinator(navigationController: mockNav)
        favoritesModel = TableViewModel(coordinator: coordinator)
        
        coreDataStack = MockCoreDataStack(name: "MuSe")
        favoritesModel.placeManager = PlaceManager(context: coreDataStack.viewContext)
    }

    override func tearDown() {
        super.tearDown()
        favoritesModel.placeManager = nil
        coreDataStack = nil
    }

    //MARK: - Tests

    func testTableHasEntry() {
        // Given
        favoritesModel.placeManager?.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: favorite, history: history, adress: adress, opening: opening, phone: phone, internet: internet, description: descript)

        // When
        let hasEntry = favoritesModel.tableHasEntry()

        // Then
        XCTAssertTrue(hasEntry)
    }

    func  testNumberOfRows() {
        // Given
        favoritesModel.placeManager?.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: favorite, history: history, adress: adress, opening: opening, phone: phone, internet: internet, description: descript)

        // When
        let numberOfRows = favoritesModel.numberOfRowsInSection()

        // Then
        XCTAssertEqual(favoritesModel.placeManager?.fetchedResultsController.count, 1)
        XCTAssertEqual(numberOfRows, 1)
    }

    func testDataForCell_WhenDataAreFound_theAnArrayOfPlacesIsCreated() {
        // Given
        favoritesModel.placeManager?.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: favorite, history: history, adress: adress, opening: opening, phone: phone, internet: internet, description: descript)

        // When
        let places = favoritesModel.dataForCell()
        guard let place = places?[0] else { return }

        // Then
        XCTAssertEqual(place.title, title)
    }

    func testDeletingRow_whenARowIsDeleted_thenThePlaceFavoriteIsFalse() {
        // Given
        favoritesModel.placeManager?.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: favorite, history: history, adress: adress, opening: opening, phone: phone, internet: internet, description: descript)

        // When
        guard let place = favoritesModel.placeManager?.fetchedResultsController[0] else { return }

        XCTAssertEqual(place.favorite, true)
        favoritesModel.deletingRow(place)

        // Then
        XCTAssertEqual(place.favorite, false)
    }
}
