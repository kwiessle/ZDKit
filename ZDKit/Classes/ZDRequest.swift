//
//  ZDRequest.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 06/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public class Request {
    
    
    public init() {}
    
    public func fetchData<T: Decodable>(req: URLRequest, for type: T.Type, completion: @escaping(T?) -> Void) {
        URLSession.shared.dataTask(with: req) { data, res, err in
            guard err == nil else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDTools Request : \(String(describing: err))")
                return
            }
            guard let getData = data else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDTools Request : Data Not Recieved")
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let JSONData = try? decoder.decode(T.self, from: getData) else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDTools Request : Fetching From Data to Model failed")
                return
            }
            DispatchQueue.main.async { completion(JSONData) }
            }.resume()
    }
    
    
    
    
    public func prepareAuthorizedRequest(url: String, type: AuthorizationType, credential: String) -> URLRequest? {
        guard let url = URL(string: url) else {
            print("Failed to prepare URL")
            return nil
        }
        var request = URLRequest(url: url)
        request.addValue("\(type) \(credential)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    
    public func preapareDataRequest<T : Encodable>(scheme: SendableScheme<T>) -> URLRequest?
    {
        guard let url = URL(string: scheme.url) else {
            print("Failed to prepare URL")
            return nil
        }
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let json = try? encoder.encode(scheme.data) else {
            print("Failed to generate JSON from model : \(String(describing: scheme.data.self))")
            return nil
        }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = scheme.method.rawValue
        request.httpBody = json
        if scheme.authType != .None {
            request.addValue("\(scheme.authType) \(scheme.authCredential)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    
    
    
    public func sendData(req: URLRequest, completion: @escaping(Int?) -> Void) {
        URLSession.shared.dataTask(with: req) { data, res, err in
            guard err == nil else {
                DispatchQueue.main.async { completion(nil) }
                print("POST error"); return
                
            }
            guard res != nil else {
                DispatchQueue.main.async { completion(nil) }
                print("POST res");
                return
            }
            if let code = res as? HTTPURLResponse {
                DispatchQueue.main.async { completion(code.statusCode) }
            } else {
                completion(nil)
            }
            }.resume()
        
    }
    
}

