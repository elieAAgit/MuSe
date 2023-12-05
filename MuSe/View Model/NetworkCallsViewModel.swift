//
//  NetworkCallsViewModel.swift
//  MuSe
//
//  Created by Elie Arquier on 14/04/2022.
//

import Foundation

// protocol allowing you to call the function to go to Home once the network calls have ended
protocol OtherPageDelegate {
    func otherPage()
}

final class NetworkCallsViewModel: NSObject {
    private var networkModel = NetworkModel()
    var delegate: OtherPageDelegate?

    func start() {
        networkModel.start()
        networkMuseum()
    }
}
// MARK: - Networks
extension NetworkCallsViewModel {

    // MARK: - Museum

    /// Museum API
    private func networkMuseum() {
        NetworkManager.shared.getNetworkResponse(url: ApiKeys.museumUrl, decodable: MuseumDecodable.self) { result in
            switch result {
            case .success(let response):
                self.networkModel.museum(response: response)
                print(Categories.museum.id)
            case .failure(let error):
                print(error)
            }
            // Next
            self.networkTheatre()
        }
    }

    // MARK: - Theatre

    /// Theatre API
    private func networkTheatre() {
        NetworkManager.shared.getNetworkResponse(url: ApiKeys.theatreUrl, decodable: TheatreDecodable.self) { result in
            switch result {
            case .success(let response):
                self.networkModel.theatre(response: response)
                print(Categories.theatre.id)
            case .failure(let error):
                print(error)
            }
            // next
            self.networkGarden()
        }
    }

    // MARK: - Garden

    /// Garden API
    private func networkGarden() {
        NetworkManager.shared.getNetworkResponse(url: ApiKeys.gardenUrl, decodable: GardenDecodable.self) { result in
            switch result {
            case .success(let response):
                self.networkModel.garden(response: response)
                print(Categories.garden.id)
            case .failure(let error):
                print(error)
            }
            // Next
            self.networkLibrary()
        }
    }

    // MARK: - Library

    /// Library API
    private func networkLibrary() {
        NetworkManager.shared.getNetworkResponse(url: ApiKeys.libraryUrl, decodable: LibraryDecodable.self) { result in
            switch result {
            case .success(let response):
                self.networkModel.library(response: response)
                print(Categories.library.id)
            case .failure(let error):
                print(error)
            }
            // Go to Home
            self.delegate?.otherPage()
        }
    }
}
