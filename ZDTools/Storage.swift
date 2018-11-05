//
//  Storage.swift
//  ZDTools
//
//  Created by Kiefer Wiessler on 24/10/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import UIKit
import CoreData



public final class Storage {
    
 
    public var ctx : NSManagedObjectContext?
    
    public func load<T>(identifier: String, for type: T.Type, completion: @escaping(T?) -> Void) {
        if let context = ctx {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: identifier))
            do {
                let stored = try(context.fetch(request)) as? T
                completion(stored)
            }
            catch {
                print("LocalStorage : Failed to load local data with identifier : '\(identifier)'")
                completion(nil)
            }
        }
    }

    public func clear(entitiesNames: [String], completion: @escaping (Bool) -> Void) -> Void {
        if let context = ctx {
            do {
                for entity in entitiesNames {
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
                    let objects = try(context.fetch(request)) as? [NSManagedObject]
                    for object in objects! {
                        context.delete(object)
                    }
                }
                try(context.save())
                completion(true)
            }
            catch let err {
                print("LocalStorage : Failed to clear local data.\n \(err)")
                completion(false)
            }
        }
    }

    public func createEntity<T>(for type: T.Type) -> T {
             return NSEntityDescription.insertNewObject(forEntityName: String(describing: type), into: ctx!) as! T
    }


    public func save() -> Void {
        if let context = ctx {
            do { try(context.save()) }
            catch let err { print(err) }
        }
    }
}
