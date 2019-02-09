//
//  SavedAlbumData+CoreDataProperties.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import CoreData

extension Albums {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Albums> {
        return NSFetchRequest<Albums>(entityName: "Albums")
    }
    
    @NSManaged public var artist: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
}
