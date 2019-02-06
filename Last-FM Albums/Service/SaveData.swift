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
            guard let results = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest) as? [SavedAlbumData] else { return [] }
            for result in results {
                guard let artist = result.artist, let name = result.name, let imageData = result.image, let image = UIImage(data: imageData), let tracks = result.tracks else { return [] }
                let emptyElement = DataStructure(artist: artist, image: image, name: name, tracks: tracks)
                fetchedTableData.append(emptyElement)
            }
        } catch {
            print(error)
        }
        return fetchedTableData
    }
    
    func localStorageSave(artist: String, image: UIImage, name: String, tracks: String) {
        
        var managedObject: [SavedAlbumData] = []
        let emptyElement = SavedAlbumData()

        emptyElement.artist = artist
        emptyElement.image = image.pngData()
        emptyElement.name = name
        emptyElement.tracks = tracks
        managedObject.append(emptyElement)
        CoreDataManager.instance.saveContext()
        
    }
}
