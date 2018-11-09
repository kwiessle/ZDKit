//
//  AuthorizationType.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 09/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public enum AuthorizationType : String {
    case Basic = "Basic"
    case Bearer = "Bearer"
    case Digest = "Digest"
    case HOBA = "HOBA"
    case Mutual = "Mutual"
    case AWS4 = "AWS4-HMAC-SHA256"
}
