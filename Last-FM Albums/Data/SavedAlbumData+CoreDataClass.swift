//
//  SavedAlbumData+CoreDataClass.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

@objc(SavedAlbumData)
public class SavedAlbumData: NSManagedObject {
    
    convenience init() {
        self.init(context: CoreDataManager.instance.managedObjectContext)
    }
}
