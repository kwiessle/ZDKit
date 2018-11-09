//
//  [HTTPQuery]+Extension.swift
//  ZDKit
//
//  Created by Kiefer Wiessler on 09/11/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation

extension Array where Element == HTTPQuery {
    
    func absoluteString() -> String? {
        guard self.first != nil else { return nil }
        var absolute = String()
        self.forEach { query in
            if query != self.first { absolute.insert("&", at: absolute.endIndex) }
            absolute += "\(query.key)=\(query.value)"
        }
        return absolute
    }

}
