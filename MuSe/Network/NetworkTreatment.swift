//
//  NetworkTreatment.swift
//  MuSe
//
//  Created by Elie ARquier on 14/04/2022.
//

import Foundation

final class NetworkTreatment {
    /// Decoding json file
    func treatment(url: ApiKey, response: Decodable) -> AnyObject? {
        // Museum
        if url.body == ApiKeys.museumUrl.body {
            let museum = response as! MuseumDecodable

            return museum as AnyObject
        }
        // Theatre
        else if url.body == ApiKeys.theatreUrl.body {
            let theatre = response as! TheatreDecodable

            return theatre as AnyObject
        }
        // Garden
        else if url.body == ApiKeys.gardenUrl.body {
            let garden = response as! GardenDecodable

            return garden as AnyObject
        }
        else {
            return nil
        }
    }
}
