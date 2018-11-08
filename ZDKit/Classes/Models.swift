//
//  SendableScheme.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 06/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public enum RequestMethod : String {
    case POST = "POST"
    case PUT = "PUT"
    case GET = "GET"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}

public enum AuthorizationType : String {
    case Basic = "Basic"
    case Bearer = "Bearer"
    case Digest = "Digest"
    case HOBA = "HOBA"
    case Mutual = "Mutual"
    case AWS4 = "AWS4-HMAC-SHA256"
}

public struct ZDAuth <T> {
    public let uid : String
    public let secret : String
    public var credential : T?
    
    public init (uid: String, secret: String) {
        self.uid = uid
        self.secret = secret
    }
    
    public mutating func set(credential: T) {
        self.credential = credential
    }
    
}

public struct URLQuery {
    public let name : String
    public let value : String
    
    public init(_ name: String, value: String) {
        self.name = name
        self.value = value
    }
}
