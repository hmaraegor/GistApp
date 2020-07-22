//
//  DecodeService.swift
//  GistApp
//
//  Created by Egor on 13/07/2020.
//  Copyright © 2020 Egor Khmara. All rights reserved.
//

import Foundation

class DecodeService {
    
    func decodeData<T: Codable>(data: Data, dataType: DataType, completionHandler:
        @escaping (Result<T, NetworkServiceError>) -> ()) {
        
        
        //            do {
        //                let json = try JSONSerialization.jsonObject(with: data, options: [])
        //                print("json\n", json)
        //            } catch {
        //                print("json error")
        //            }
        
        switch dataType {
            
        case .json:
            
            do {
                let gistList = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(gistList))
            } catch {
                completionHandler(.failure(.jsonDecoding))
            }
            
        case .string:
            
            let str: T = String(decoding: data, as: UTF8.self) as! T
            completionHandler(.success(str))
            
        }
        
    }
    
}
