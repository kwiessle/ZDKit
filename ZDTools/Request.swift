//
//  Request.swift
//  ZDTools
//
//  Created by Kiefer Wiessler on 24/10/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import UIKit

final public class Request {
    

    private let cache = NSCache<NSString, UIImage>()
    public var host = ""
    
    
    // MARK - GET
    
    public func get<T: Decodable>(req: URLRequest, for type: T.Type, completion: @escaping(T?) -> Void) {
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
    
    
    // MARK - IMAGE DOWNLOADER
    
    public func imageDownloader(url: String, completion: @escaping(UIImage?) -> Void) {
        guard let req = URL(string:"\(host)\(url)") else { return }
        let qos = DispatchQoS.background.qosClass
        
        if let cached = cache.object(forKey: NSString(string: url)) { completion(cached); return }
        
        DispatchQueue.global(qos: qos).async { [unowned self] in
            guard let data = try? Data(contentsOf: req), let image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil) }
                print("ZDTools Request : Failed to Build Image from Data")
                return
            }
            self.cache.setObject(image, forKey: NSString(string: url))
            DispatchQueue.main.async { completion(image) }
        }
    }
    
}
