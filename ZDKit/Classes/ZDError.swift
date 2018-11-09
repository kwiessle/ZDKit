//
//  ZDError.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 09/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

public class ZDError {
    
    var context : String
    
    
    init (context: String) {
        self.context = context
    }
    
    func ZDThrowError(scope: String, message: String) -> Void {
        print("[\(context)] : \(scope)() -> \(message)")
    }
}
