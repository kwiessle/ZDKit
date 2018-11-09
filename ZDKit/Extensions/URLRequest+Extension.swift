//
//  URLRequest+Extension.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 08/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

extension URLRequest {

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
        guard let JSON = try? encoder.encode(data) else {
            ZDError(context: "URLRequest").ZDThrowError(scope: "withData", message: "Failed to generate JSON from model : \(String(describing: data.self))")
            return
        }
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.httpBody = JSON
    }
    
    public mutating func withBody(plainText: String) -> Void {
        self.httpBody = plainText.data(using: .utf8)
    }

    public mutating func withBody(queries: [HTTPQuery]) -> Void {
        guard let absoluteQueries = queries.absoluteString() else { return }
        self.httpBody = absoluteQueries.data(using: .utf8)
    }
    
    public mutating func withQueries(_ queries: [HTTPQuery]) -> Void {
        guard let url = self.url, let absoluteQueries = queries.absoluteString() else { return }
        self.url = URL(string: "\(url.absoluteString)?\(absoluteQueries)")
    }
}
