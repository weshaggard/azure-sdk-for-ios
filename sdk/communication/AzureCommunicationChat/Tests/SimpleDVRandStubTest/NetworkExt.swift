//
//  NetworkExt.swift
//  testNetwork
//
//  Created by Jáir Myree on 6/7/21.
//

import Foundation
import DVR
import OHHTTPStubsSwift

extension URLSession {
    enum DataType {
        case Live, Record, Playback
    }
}

class NetworkRequest {
    private static let session = URLSession.shared
    
    private static let testUrl = URL.init(string: "https://api.publicapis.org/entries")
    
    static func makeRequest(completion: @escaping (Data?, URLResponse?, Error?)->Void) {
        session.dataTask(with: testUrl!) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                completion(data,response,error)
            }
        }.resume()
    }
    
    
}

