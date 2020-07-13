//
//  EncodeService.swift
//  GistApp
//
//  Created by Egor on 13/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

class EncodeService {
    
    func encodeData<T: Codable>(model: T) -> (Data?, Error?) {
        
            do {
                let encodedData = try JSONEncoder().encode(model)
                return (encodedData, nil)
            } catch {
                return(nil, NetworkServiceError.jsonDecoding)
            }
        
    }
    
}
