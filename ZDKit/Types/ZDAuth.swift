//
//  ZDAuth.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 09/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

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
