//
//  NetworkManagerTests.swift
//  MuSeTests
//
//  Created by Elie Arquier on 02/12/2023.
//

import XCTest
@testable import MuSe

class NetworkManagerTest: XCTestCase {
   
    // MARK: - Network call test

    func testGetMuseumShouldPostFailedCallbackIfNil() {
        //Given
        var response: NetworkError?
        let networkCall = NetworkManager(session: URLSessionFake(data: nil, response: nil, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        networkCall.getNetworkResponse(url: ApiKeys.museumUrl, decodable: MuseumDecodable.self) { result in
            
            switch result {
            case .success(_):
                print("unexpected success")
            case .failure(let error):
                response = error
            }

            //Then
            XCTAssertEqual(NetworkError.data, response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetMuseumShouldPostFailedCallbackIfError() {
        //Given
        var response: NetworkError?
        let networkCall = NetworkManager(session: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: FakeResponseData.networkError))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        networkCall.getNetworkResponse(url: ApiKeys.museumUrl, decodable: MuseumDecodable.self) { result in
            
            switch result {
            case .success(_):
                print("unexpected success")
            case .failure(let error):
                response = error
            }

            //Then
            XCTAssertEqual(NetworkError.error, response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)

    }

    func testGetMuseumShouldPostFailedCallbackIfIncorrectData() {
        //Given
        var response: NetworkError?
        let networkCall = NetworkManager(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        networkCall.getNetworkResponse(url: ApiKeys.museumUrl, decodable: MuseumDecodable.self) { result in

            switch result {
            case .success(_):
                print("unexpected success")
            case .failure(let error):
                response = error
            }

            //Then
            XCTAssertEqual(NetworkError.decode, response)
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetMuseumShouldPostFailedCallbackIfResponseKO() {
        //Given
        var response: NetworkError?
        let networkCall = NetworkManager(session: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseKO, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        networkCall.getNetworkResponse(url: ApiKeys.museumUrl, decodable: MuseumDecodable.self) { result in

            switch result {
            case .success(_):
                print("unexpected success")
            case .failure(let error):
                response = error
            }

            //Then
            XCTAssertEqual(NetworkError.response, response)
            expectation.fulfill()

        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetMuseumShouldSuccedIfAllOK() {
        //Given
        var response: String?
        let networkCall = NetworkManager(session: URLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        networkCall.getNetworkResponse(url: ApiKeys.museumUrl, decodable: MuseumDecodable.self) { result in

            switch result {
            case .success(_):
                response = "succes"
            case .failure(_):
                print("unexpected error")
            }

            //Then
            XCTAssertEqual("succes", response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetTheatreShouldSuccedIfAllOK() {
        //Given
        var response: String?
        let networkCall = NetworkManager(session: URLSessionFake(data: FakeResponseData.correctTheatreData, response: FakeResponseData.responseOK, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        networkCall.getNetworkResponse(url: ApiKeys.theatreUrl, decodable: TheatreDecodable.self) { result in

            switch result {
            case .success(_):
                response = "succes"
            case .failure(_):
                print("unexpected error")
            }

            //Then
            XCTAssertEqual("succes", response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGardenShouldSuccedIfAllOK() {
        //Given
        var response: String?
        let networkCall = NetworkManager(session: URLSessionFake(data: FakeResponseData.correctGardenData, response: FakeResponseData.responseOK, error: nil))

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        networkCall.getNetworkResponse(url: ApiKeys.gardenUrl, decodable: GardenDecodable.self) { result in

            switch result {
            case .success(_):
                response = "succes"
            case .failure(_):
                print("unexpected error")
            }

            //Then
            XCTAssertEqual("succes", response)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
