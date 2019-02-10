//
//  Tracks +CoreDataClass.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

@objc(Tracks)
public class Tracks: NSManagedObject {
    
    convenience init() {
        self.init(context: CoreDataManager.instance.managedObjectContext)
    }
}
