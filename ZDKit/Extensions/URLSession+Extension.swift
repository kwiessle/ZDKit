//
//  URLSession+Extension.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 08/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public extension URLSession {
    public func synchronousDataTask(with request: URLRequest) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        let semaphore = DispatchSemaphore(value: 0)
        _ = self.dataTask(with: request) {
            data = $0
            response = $1
            error = $2
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(timeout: .distantFuture)
        return (data, response, error)
    }
}
