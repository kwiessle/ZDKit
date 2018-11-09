//
//  HTTPQuery.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 09/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public struct HTTPQuery : Equatable {
    public let key : String
    public let value : String
    
    public init(_ key: String, value: String) {
        self.key = key
        self.value = value
    }
}
