//
//  NetworkRequestService.swift
//  GistApp
//
//  Created by Egor on 13/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

class NetworkRequestService {
    
    func postData<T: Codable>(model: T, url: String, completionHandler:
        @escaping (Result<Int, NetworkServiceError>) -> ()) {
    
        
        let (encodedData, error) = EncodeService().encodeData(model: model)
        if error != nil {
            completionHandler(.failure(.modelEncoding))
        }
        guard encodedData != nil else { return }
        
        guard let url = URL(string: url) else {
            completionHandler(.failure(.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = encodedData
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
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
            
            completionHandler(.success(httpResponse.statusCode))
            
            

        }.resume()
    }
}
