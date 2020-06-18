//
//  NetworkService.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 10.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

class NetworkService {
    
    private init() {}
    
    static func getData(url: String, completionHandler:
        @escaping (Result<[Gist], NetworkServiceError>) -> ()) {
        
        guard let url = URL(string: url) else { completionHandler(.failure(.badURL))
            return
        }
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            print("response\n", response)
            guard let response = response else {
                completionHandler(.failure(.noResponse))
                return }
            guard let data = data else {
                completionHandler(.failure(.noData))
                return }
            if error != nil {
                completionHandler(.failure(.networkError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.badResponse))
                return
            }

            do {
                let gistList: [Gist] = try JSONDecoder().decode([Gist].self, from: data)
                completionHandler(.success(gistList))
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print("JSON\n", json)
            } catch {
                completionHandler(.failure(.jsonDecoding))
            }

        }.resume()
    }
}
