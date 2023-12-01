//
//  NetworkCallsViewModel.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import Foundation

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

    private func networkMuseum() {
        NetworkManager.shared.getNetworkResponse(url: ApiKeys.museumUrl, decodable: MuseumDecodable.self) { result in
            switch result {
            case .success(let response):
                self.networkModel.museum(response: response)
                print(Categories.museum.id)
            case .failure(let error):
                print(error)
            }
            self.networkTheatre()
        }
    }

    // MARK: - Theatre

    private func networkTheatre() {
        NetworkManager.shared.getNetworkResponse(url: ApiKeys.theatreUrl, decodable: TheatreDecodable.self) { result in
            switch result {
            case .success(let response):
                self.networkModel.theatre(response: response)
                print(Categories.theatre.id)
            case .failure(let error):
                print(error)
            }
            self.networkGarden()
        }
    }

    // MARK: - Garden

    private func networkGarden() {
        NetworkManager.shared.getNetworkResponse(url: ApiKeys.gardenUrl, decodable: GardenDecodable.self) { result in
            switch result {
            case .success(let response):
                self.networkModel.garden(response: response)
                print(Categories.garden.id)
            case .failure(let error):
                print(error)
            }
            self.networkLibrary()
        }
    }

    // MARK: - Library

    private func networkLibrary() {
        NetworkManager.shared.getNetworkResponse(url: ApiKeys.libraryUrl, decodable: LibraryDecodable.self) { result in
            switch result {
            case .success(let response):
                self.networkModel.library(response: response)
                print(Categories.library.id)
            case .failure(let error):
                print(error)
            }
            self.networkModel.loadingFavoritesAndHistory()
            self.delegate?.otherPage()
        }
    }
}
