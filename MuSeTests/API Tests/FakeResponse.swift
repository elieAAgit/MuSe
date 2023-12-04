//
//  FakeResponse.swift
//  MuSeTests
//
//  Created by Elie Arquier on 23/11/2023.
//

import Foundation

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

class URLSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFakeOld()
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        let task = URLSessionDataTaskFakeOld()
        
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}

class URLSessionDataTaskFakeOld: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?

    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }

    override func cancel() {}
}
