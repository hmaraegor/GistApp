//
//  NetworkService.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 10.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

class NetworkService<T: Codable> {
    
    typealias Completion = (Result<T, NetworkServiceError>) -> ()
    private var decodingDataType: DataType?
    
    func get(url: String, decodingDataType: DataType, _ completion: @escaping Completion) {
        self.decodingDataType = decodingDataType
        performHTTPRequest(url: url, method: "GET", data: nil, params: nil, completion)
    }
    
    func post<T: Codable>(url: String, model: T, /* params: [String: Any], */completion: @escaping Completion) {
        let (encodedData, error) = EncodeService().encodeData(model: model)
                if error != nil { completion(.failure(.modelEncoding)) }
                guard encodedData != nil else { return }
        performHTTPRequest(url: url, method: "POST", data: encodedData, params: nil/* params */, completion)
    }
    
    func put(url: String, _ completion: @escaping Completion) {
        performHTTPRequest(url: url, method: "PUT", data: nil, params: nil, completion)
    }
    
    func delete(url: String, _ completion: @escaping Completion) {
        performHTTPRequest(url: url, method: "DELETE", data: nil, params: nil, completion)
    }
    
    // MARK: - Private
    private func performHTTPRequest(url: String, method: String, data: Data?, params: [String: Any]?, _ completion: @escaping Completion) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = data
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let response = response else {
                completion(.failure(.noResponse))
                return }
            guard let data = data else {
                completion(.failure(.noData))
                return }
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(.failure(.badResponse))
                    return
            }
            
            // MARK: - Response status code
            if self.decodingDataType == nil {
                let statusCode = httpResponse.statusCode as! T
                completion(.success(statusCode))
                return
            }
            
            // MARK: - Decoding data and return object
            DecodeService().decodeData(data: data, dataType: self.decodingDataType!, completionHandler: completion)
            
        }.resume()
    }
}
