//
//  SavedAlbumData+CoreDataClass.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

@objc(Albums)
public class Albums: NSManagedObject {
    
    convenience init() {
        self.init(context: CoreDataManager.instance.managedObjectContext)
    }
}
