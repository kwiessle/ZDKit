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
    var authCredential = String()
    
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
