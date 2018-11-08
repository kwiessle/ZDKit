//
//  ZDRequest.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 06/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public class ZDRequest {
    
    
    public init() {}
    
    
    
    public func connect<T: Decodable>(req: URLRequest, for type: T.Type) -> T? {
        let (body, _, err) = URLSession.shared.synchronousDataTask(with: req)
        guard err == nil else {
            print("ZDRequest : \(String(describing: err))")
            return nil
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = body else {
            print("ZDRequest : Data Not Recieved")
            return nil
        }
        guard let JSON = try? decoder.decode(T.self, from: data) else {
            print("ZDRequest : Fetching From Data to Model failed")
            return nil
        }
        return JSON
    }
    
    public func fetch<T: Decodable>(req: URLRequest, for type: T.Type, completion: @escaping(T?) -> Void) {
        URLSession.shared.dataTask(with: req) { body, res, err in
            guard err == nil else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDRequest : \(String(describing: err))")
                return
            }
            guard let data = body else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDRequest : Data Not Recieved")
                return
            }
//            print(res.debugDescription)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let JSON = try? decoder.decode(T.self, from: data) else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDRequest : Fetching From Data to Model failed")
                return
            }
            DispatchQueue.main.async { completion(JSON) }
            }.resume()
    }
    
    
    

    
    
    
    
    public func send(req: URLRequest, completion: @escaping(HTTPURLResponse?) -> Void) {
        URLSession.shared.dataTask(with: req) { body, res, err in
            guard err == nil else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDRequest : \(String(describing: err))")
                return
                
            }
            guard res != nil else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDRequest : Request reponse is Empty");
                return
            }
            if let response = res as? HTTPURLResponse {
                DispatchQueue.main.async { completion(response) }
            } else {
                completion(nil)
            }
            }.resume()
        
    }
    
}

