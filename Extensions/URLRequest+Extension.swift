//
//  URLRequest+Extension.swift
//  Pods-ZDKitPool
//
//  Created by Kiefer Wiessler on 08/11/2018.
//

import Foundation

public extension URLRequest {
    
    
    static public func withMethod(url: String, method: RequestMethod) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        return request
    }
    
    
    public mutating func withToken(type: AuthorizationType, token: String) -> Void {
        self.addValue("\(type.rawValue) \(token)", forHTTPHeaderField: "Authorization")
    }
    
    public mutating func withData<T: Codable>(data: T) -> Void {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        guard let json = try? encoder.encode(data) else {
            print("Failed to generate JSON from model : \(String(describing: data.self))")
            return
        }
        self.httpBody = json
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    public mutating func withBody(body: String) -> Void {
        self.httpBody = body.data(using: .utf8)
    }
    
    public mutating func withQueries(_ queries: [String]) -> Void {
        var final = self.url!.absoluteString
        queries.forEach { query in
            final += query
        }
        self.url = URL(string: final)
    }
}
