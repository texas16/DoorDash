//
//  StoreSearchService.swift
//  DoorDash
//
//  Created by ilyas on 12/10/18.
//  Copyright © 2018 ilyas. All rights reserved.
//

import Foundation

struct StoreSearchService
{
    // default location - San Francisco
    var location: Observer<Location> = Observer(Location(lat: 37.773972, lng: -122.431297))
    
    // data fetching - restcall
    func getData( _ completion: @escaping (Result<[Store]>) -> Void) {
        let endpoint = Constants.ENDPOINT + "/?lat=%.06f&lng=%.06f"

        let location: Observer<Location> = Observer(Location(lat: (self.location.value.lat), lng: (self.location.value.lng)))
        
        guard let url = URL(string: String(format: endpoint, location.value.lat, location.value.lng)) else {
            fatalError()
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let decoder = JSONDecoder()
            guard let data = data else {
                return completion(.failure(NetworkError.emptyResponse))
            }
            let dataResponse = try! decoder.decode([Store].self, from: data)
            completion(
                .success(dataResponse)
            )}.resume()
    }
}
