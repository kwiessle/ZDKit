//
//  ZDRequest.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 06/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public class ZDRequest : ZDError {
    
    
    public init() {
        super.init(context: "ZDRequest")
    }
    
    
    
    public func connect<T: Decodable>(req: URLRequest, for type: T.Type) -> T? {
        let (body, _, err) = URLSession.shared.syncDataTask(with: req)
        guard err == nil else {
            ZDThrowError(scope: "connect", message: String(describing: err))
            return nil
        }
        guard let data = body else {
            ZDThrowError(scope: "connect", message: "Data Not Recieved")
            return nil
        }
        return JSONParser(for: T.self, from: data, scope: "connect")
    }


    
    
    public func fetch<T: Decodable>(req: URLRequest, for type: T.Type, completion: @escaping(T?) -> Void) {
        URLSession.shared.dataTask(with: req) { body, _, err in
            guard err == nil else {
                DispatchQueue.main.async { completion(nil) }
                self.ZDThrowError(scope: "fetch", message: String(describing: err))
                return
            }
            guard let data = body else {
                DispatchQueue.main.async { completion(nil) }
                self.ZDThrowError(scope: "fetch", message: "Data Not Recieved")
                return
            }
            DispatchQueue.main.async { completion(self.JSONParser(for: T.self, from: data, scope: "fetch")) }
            }.resume()
    }
    
    
    
    public func send(req: URLRequest, completion: @escaping(HTTPURLResponse?) -> Void) {
        URLSession.shared.dataTask(with: req) { body, res, err in
            guard err == nil else {
                DispatchQueue.main.async { completion(nil) }
                self.ZDThrowError(scope: "send", message: String(describing: err))
                return
                
            }
            guard res != nil else {
                DispatchQueue.main.async { completion(nil) }
                self.ZDThrowError(scope: "send", message: "HTTP reponse is Empty")
                return
            }
            if let response = res as? HTTPURLResponse {
                DispatchQueue.main.async { completion(response) }
            } else {
                completion(nil)
            }
            }.resume()
    }
    
    
    
    internal func JSONParser<T: Decodable>(for type: T.Type, from data: Data, scope: String) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let JSON = try? decoder.decode(T.self, from: data) else {
            ZDThrowError(scope: scope, message: "Fetching From Data to Model failed")
            return nil
        }
        return JSON
    }
    
    
    
}

