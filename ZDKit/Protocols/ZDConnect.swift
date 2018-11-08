//
//  ZDConnect.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 08/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public protocol ZDConnect {
    associatedtype T
    var auth : ZDAuth<T> { get set }
    func connect() -> Bool
}
