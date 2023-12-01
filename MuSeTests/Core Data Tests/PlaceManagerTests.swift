//
//  PlaceManagerTests.swift
//  MuSeTests
//
//  Created by Elie Arquier on 23/11/2023.
//

import XCTest
@testable import MuSe

final class PlaceManagerTests: XCTestCase {
    
    // MARK: - Properties

    var coreDataStack: MockCoreDataStack!
    var placeManager: PlaceManager!

    // Frozen Grapes and Kiwi
    var title = "title"
    var detail = "detail"
    var category = Category(title: "Musée", id: "Museum")
    var longitude = 1.9
    var latitude = 47.9167
    var favorite: Bool = false
    var history: Bool = false
    var adress = "adress"
    var opening = "12h-18h"
    var phone = "01 75 01 02 03"
    var internet = "https://www.marthastewart.com/1050596/frozen-grapes-and-kiwi"
    var descript = "description"

    // MARK: - Tests Life Cycle

    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack(name: "MuSe")
        placeManager = PlaceManager(context: coreDataStack.viewContext)
    }

    override func tearDown() {
        super.tearDown()
        placeManager = nil
        coreDataStack = nil
    }


    // MARK: - Tests

    func testAddPlace_WhenAddPlaceIsCreated_ThenShouldBeCorrectlySaved() {
        placeManager.addPlace(title: title,
                      detail: detail,
                      category: category,
                      longitude: longitude,
                      latitude: latitude,
                      favorite: favorite,
                      history: history,
                      adress: adress,
                      opening: opening,
                      phone: phone,
                      internet: internet,
                      description: descript)

        XCTAssertTrue(!placeManager.fetchedResultsController.isEmpty)
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        XCTAssertTrue(placeManager.fetchedResultsController[0].title == title)
        XCTAssertTrue(placeManager.fetchedResultsController[0].category == category)
        XCTAssertTrue(placeManager.fetchedResultsController[0].longitude == longitude)
        XCTAssertTrue(placeManager.fetchedResultsController[0].favorite == favorite)
        XCTAssertTrue(placeManager.fetchedResultsController[0].history == history)
        XCTAssertTrue(placeManager.fetchedResultsController[0].adress == adress)
        XCTAssertTrue(placeManager.fetchedResultsController[0].opening == opening)
        XCTAssertTrue(placeManager.fetchedResultsController[0].phone == phone)
        XCTAssertTrue(placeManager.fetchedResultsController[0].internet == internet)
        XCTAssertTrue(placeManager.fetchedResultsController[0].descript == descript)

        XCTAssertTrue(placeManager.fetchedResultsController.count > 0)
    }

    func testFindPlace_WhenPlaceIsSearched_thenSheShouldBeFound() {
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        XCTAssertTrue(placeManager.fetchedResultsController[0] == place)

        let result = placeManager.findPlace(place.title!)

        XCTAssertEqual(placeManager.fetchedResultsController[0], result)
    }

    func testFindFavoritesPlaces_WhenPlacesAreSearched_thenTheyShouldBeFound() {
        var favorites = [Place]()
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: true, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)

        favorites = placeManager.findPlacesFavorite()

        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites[0], placeManager.fetchedResultsController[0])
    }

    func testFindHistoryPlaces_WhenPlacesAreSearched_thenTheyShouldBeFound() {
        var history = [Place]()
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: true, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)

        history = placeManager.findPlacesHistory()

        XCTAssertEqual(history.count, 1)
        XCTAssertEqual(history[0], placeManager.fetchedResultsController[0])
    }

    func testUpdatesFavorites_WhenFavoriteIsAdded_thenFavoriteIsTrue() {
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)

        placeManager.updateFavorite(place)

        XCTAssertTrue(place.favorite == false)
        XCTAssertTrue(placeManager.fetchedResultsController[0].favorite == true)
    }

    func testUpdatesHistory_WhenHistoryIsAdded_thenHistoryIsTrue() {
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)

        placeManager.updateHistory(place)

        XCTAssertTrue(place.history == false)
        XCTAssertTrue(placeManager.fetchedResultsController[0].history == true)
    }

    func testRemoveFromHistory_WhenFavoriteIsRemoved_thenHistoryIsFalse() {
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: true, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)

        placeManager.removeFromHistory(place)

        XCTAssertTrue(place.history == true)
        XCTAssertTrue(placeManager.fetchedResultsController[0].history == false)
    }

    func testRemovePlace_WhenPlaceIsRemoved_thenShouldNotBeInTheDataBase() {
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)

        placeManager.removePlace(place)

        XCTAssertEqual(placeManager.fetchedResultsController.count, 0)
    }

    func testDeleteAll_WhenAllPlacesAreDeleted_thenTheDataBaseIsEmpty() {
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)

        placeManager.deleteAll()

        XCTAssertEqual(placeManager.fetchedResultsController.count, 0)
    }
}
