//
//  NetworkManager.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import Foundation

enum NetworkError: String, Error {
    case data = "error data"
    case error = "error"
    case response = "error response"
    case decode = "error decode"
}

final class NetworkManager {

    private let treatment = NetworkTreatment()

    // Singleton pattern
    static var shared = NetworkManager()
    private init() {}

    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)

    init(session: URLSession) {
        self.session = session
    }

    //API request
    func getNetworkResponse<T: Decodable>(url: ApiKey, decodable: T.Type, callback: @escaping (Result<T?, NetworkError>) -> Void) {
        let request = getRequest(base: url.base, body: url.body, method: url.method)

        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data else {
                    callback(.failure(.data))
                    return
                }

                guard error == nil else {
                    callback(.failure(.error))
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.response))
                    return
                }

                do {
                    let responseJSON = try JSONDecoder().decode(decodable, from: data)
                    let response: T? = self.treatment.treatment(url: url, response: responseJSON as Decodable) as? T

                    callback(.success(response))
                } catch {
                    callback(.failure(.decode))
                }
            }
        }
        task?.resume()
    }

    ///  returns a URLRequest from the String of the API address.
    private func getRequest(base: String, body: String, method: Methods) -> URLRequest {
        var requestUrl: URL
        var request: URLRequest

        //get method must not have a body
        if method == .get {
            requestUrl = URL(string: base + body)!
            request = URLRequest(url: requestUrl)

            request.httpMethod = method.rawValue

            return request
        } else {
            requestUrl = URL(string: base)!
            request = URLRequest(url: requestUrl)

            request.httpMethod = method.rawValue

            request.httpBody = body.data(using: .utf8)

            return request
        }
    }
}

