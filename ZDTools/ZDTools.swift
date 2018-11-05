//
//  ZDTools.swift
//  ZDTools
//
//  Created by Kiefer Wiessler on 24/10/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import Foundation
import CoreData

open class ZD {

    
    static public let storage = Storage()
    static public let shared = ZD()
    
//    public func setRequestHost(url: String) {
//        ZD.request.host = url
//    }
    
    public func setStorageContext(context: NSManagedObjectContext) {
        ZD.storage.ctx = context
    }
}
