//
//  NetworkServiceError.swift
//  iTunesSearchAPI
//
//  Created by Egor Khmara on 11.06.2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

enum NetworkServiceError: Error {
    case badURL
    case noResponse
    case noData
    case jsonDecoding
    case networkError
    case badResponse
}
