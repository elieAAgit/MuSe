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

    // Fake object
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
    var internet = "https://openclassrooms.com"
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
        //Given
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
        //Then
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
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        XCTAssertTrue(placeManager.fetchedResultsController[0] == place)
        //When
        let result = placeManager.findPlace(place.title!)
        //Then
        XCTAssertEqual(placeManager.fetchedResultsController[0], result)
    }

    func testFindPlace_WhenPlaceIsSearchedAndUnknown_thenSheShouldNotBeFound() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        XCTAssertTrue(placeManager.fetchedResultsController[0] == place)
        //When
        let result = placeManager.findPlace("Some title")

        XCTAssertNil(result)
    }

    func testFindFavoritesPlaces_WhenPlacesAreSearched_thenTheyShouldBeFound() {
        //Given
        var favorites = [Place]()
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: true, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        //When
        favorites = placeManager.findPlacesFavorite()
        //Then
        XCTAssertEqual(favorites.count, 1)
        XCTAssertEqual(favorites[0], placeManager.fetchedResultsController[0])
    }

    func testFindHistoryPlaces_WhenPlacesAreSearched_thenTheyShouldBeFound() {
        //Given
        var history = [Place]()
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: true, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        //When
        history = placeManager.findPlacesHistory()
        //Then
        XCTAssertEqual(history.count, 1)
        XCTAssertEqual(history[0], placeManager.fetchedResultsController[0])
    }

    func testFindPlaces_WhenPlacesAreSearched_thenTheyShouldNotBeFound() {
        //Given
        var places = [Place]()
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        //When
        places = placeManager.findPlaces("history")
        //Then
        XCTAssertEqual(places.count, 0)
    }

    func testUpdatesFavorites_WhenFavoriteIsAdded_thenFavoriteIsTrue() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        XCTAssertTrue(place.favorite == false)
        //When
        placeManager.updateFavorite(place)
        //Then
        XCTAssertTrue(placeManager.fetchedResultsController[0].favorite == true)
    }

    func testUpdatesHistory_WhenHistoryIsAdded_thenHistoryIsTrue() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        XCTAssertTrue(place.history == false)
        //When
        placeManager.updateHistory(place)
        //Then
        XCTAssertTrue(placeManager.fetchedResultsController[0].history == true)
    }

    func testRemoveFromHistory_WhenFavoriteIsRemoved_thenHistoryIsFalse() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: true, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        XCTAssertTrue(place.history == true)
        //When
        placeManager.removeFromHistory(place)
        //Then
        XCTAssertTrue(placeManager.fetchedResultsController[0].history == false)
    }

    func testRemovePlace_WhenPlaceIsRemoved_thenShouldNotBeInTheDataBase() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        let place = placeManager.fetchedResultsController[0]

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        //When
        placeManager.removePlace(place)
        //Then
        XCTAssertEqual(placeManager.fetchedResultsController.count, 0)
    }
    
    func testfindPlaceFavoriteOrHistory_whenNothingIsFound_thenAddThePlace() {
        //Given
        let result = placeManager.findPlaceFavoriteOrHistory(title: title, latitude: latitude, longitude: longitude)
        //Then
        XCTAssertEqual(false, result)
    }

    func testfindPlaceFavoriteOrHistory_whenFavoriteIsFound_thenDontAddThePlace() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: true, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)
        //When
        let result = placeManager.findPlaceFavoriteOrHistory(title: title, latitude: latitude, longitude: longitude)
        //Then
        XCTAssertEqual(true, result)
    }

    func testfindPlaceFavoriteOrHistory_whenHistoryIsFound_thenDontAddThePlace() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: true, adress: adress, opening: opening, phone: phone, internet: internet, description: description)
        //When
        let result = placeManager.findPlaceFavoriteOrHistory(title: title, latitude: latitude, longitude: longitude)
        //Then
        XCTAssertEqual(true, result)
    }

    func testDeleteAll_WhenAllPlacesAreDeleted_thenTheDataBaseIsEmpty() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        //When
        placeManager.deleteAll()
        //Then
        XCTAssertEqual(placeManager.fetchedResultsController.count, 0)
    }

    func testDeleteAll_WhenAllPlacesAreDeletedExceptFavorite_thenTheDataBaseIsNotEmpty() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: true, history: false, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        //When
        placeManager.deleteAll()
        //Then
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
    }

    func testDeleteAll_WhenAllPlacesAreDeletedExceptHisory_thenTheDataBaseIsNotEmpty() {
        //Given
        placeManager.addPlace(title: title, detail: detail, category: category, longitude: longitude, latitude: latitude, favorite: false, history: true, adress: adress, opening: opening, phone: phone, internet: internet, description: description)

        // Verification of the addition of the recipe into the favorites
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
        //When
        placeManager.deleteAll()
        //Then
        XCTAssertEqual(placeManager.fetchedResultsController.count, 1)
    }
}
