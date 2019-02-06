//
//  SavedAlbumData+CoreDataProperties.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

extension SavedAlbumData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedAlbumData> {
        return NSFetchRequest<SavedAlbumData>(entityName: "SavedAlbumData")
    }
    
    @NSManaged public var artist: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var tracks: String?
}
