//
//  NetworkManagerTests.swift
//  MuSeTests
//
//  Created by Elie Arquier on 02/12/2023.
//

import XCTest
@testable import MuSe

class NetworkManagerTest: XCTestCase {

    // MARK: - Network call tests
    
    func testGetMuseumShouldPostFailedCallbackIfNoNothing() {
        //Given
        var response: NetworkError?
        let networkCall = NetworkManager(session: NetworkURLSessionFake(data: nil, response: nil, error: nil))
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
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetMuseumShouldPostFailedCallbackIfError() {
        //Given
        var response: NetworkError?
        let networkCall = NetworkManager(session: NetworkURLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: FakeResponseData.networkError))
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
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetMuseumShouldPostFailedCallbackIfIncorrectData() {
        //Given
        var response: NetworkError?
        let networkCall = NetworkManager(session: NetworkURLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
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
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetMuseumShouldPostFailedCallbackIfAllOK() {
        //Given
        let networkCall = NetworkManager(session: NetworkURLSessionFake(data: FakeResponseData.correctData, response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        networkCall.getNetworkResponse(url: ApiKeys.museumUrl, decodable: MuseumDecodable.self) { result in

        //Then
        XCTAssertNotNil(result)
        expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
