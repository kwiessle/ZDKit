//
//  Storage.swift
//  ZDTools
//
//  Created by Kiefer Wiessler on 24/10/2018.
//  Copyright © 2018 Kiefer Wiessler. All rights reserved.
//

import UIKit
import CoreData

final class Storage {
    
//    static let shared = Storage()
//    private let appDelegate = UIApplication.shared.delegate  as? AppDelegate
//    private lazy var context = appDelegate!.persistentContainer.viewContext
//
//
//    func load<T>(identifier: String, for type: T.Type, completion: @escaping(T?) -> Void) {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: identifier))
//        do {
//            let stored = try(context.fetch(request)) as? T
//            completion(stored)
//        }
//        catch {
//            print("LocalStorage : Failed to load local data with identifier : '\(identifier)'")
//            completion(nil)
//        }
//    }
//
//
//
//    func createEntity<T>(for type: T.Type) -> T {
//        return NSEntityDescription.insertNewObject(forEntityName: String(describing: type), into: context) as! T
//    }
//
//
//    func save() -> Void {
//        do { try(context.save()) }
//        catch let err { print(err) }
//    }
}
