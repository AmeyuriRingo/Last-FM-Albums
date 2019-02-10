//
//  Tracks +CoreDataProperties.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

extension Tracks {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tracks> {
        return NSFetchRequest<Tracks>(entityName: "Tracks")
    }
    
    @NSManaged public var name: String?
}
