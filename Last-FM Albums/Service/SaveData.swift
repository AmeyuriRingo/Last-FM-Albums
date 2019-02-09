//
//  SaveData.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SaveData {
    
    func fetchDataFromDB() -> [DataStructure] {
        
        var fetchedTableData: [DataStructure] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedAlbumData")
        do {
            guard let results = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest) as? [Albums] else { return [] }
            for result in results {
                guard let artist = result.artist, let name = result.name, let imageData = result.image, let image = UIImage(data: imageData) else { return [] }
                let emptyElement = DataStructure(artist: artist, image: image, name: name)
                fetchedTableData.append(emptyElement)
            }
        } catch {
            print(error)
        }
        return fetchedTableData
    }
    
    func localStorageSave(artist: String, image: UIImage, name: String) {
        
        var managedObject: [Albums] = []
        let emptyElement = Albums()
// пихать URL картинки, а не саму картинку
        emptyElement.artist = artist
        emptyElement.image = image.pngData()
        emptyElement.name = name
        managedObject.append(emptyElement)
        CoreDataManager.instance.saveContext()
        
    }
}
