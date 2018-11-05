//
//  Request.swift
//  ZDTools
//
//  Created by Kiefer Wiessler on 24/10/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import UIKit

public enum RequestMethod : String {
    case POST = "POST"
    case PUT = "PUT"
    case GET = "GET"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

public enum AuthorizationType : String {
    case None = ""
    case Basic = "Basic"
    case Bearer = "Bearer"
    case Digest = "Digest"
    case HOBA = "HOBA"
    case Mutual = "Mutual"
    case AWS4 = "AWS4-HMAC-SHA256"
}

public struct SendableScheme <T : Encodable> {
    var url  : String
    var data : T
    var method : RequestMethod
    var authType : AuthorizationType = .None
    var authCredential : String = ""
    var codingStrategy : JSONEncoder.KeyEncodingStrategy = .useDefaultKeys
    
    public init (url: String, method: RequestMethod, data: T) {
        self.url = url
        self.method = method
        self.data = data
    }
    
    public mutating func setAuthorization(type: AuthorizationType, credential: String) {
        authType = type
        authCredential = credential
    }
}

public class Request {
    

    public init() {}
    
    private let cache = NSCache<NSString, UIImage>()

    
    
  
    
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
        guard let json = try? JSONEncoder().encode(scheme.data) else {
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
    
    
    
    
    // MARK - IMAGE DOWNLOADER
    
    public func imageDownloader(url: String, completion: @escaping(UIImage?) -> Void) {
        guard let req = URL(string: url) else { return }
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
