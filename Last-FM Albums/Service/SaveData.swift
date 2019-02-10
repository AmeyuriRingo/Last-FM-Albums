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
    
    func fetchDataFromAlbumsDB() -> [AlbumDataStructure] {
        //fetch albums method
        var fetchedTableData: [AlbumDataStructure] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Albums")
        do {
            guard let results = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest) as? [Albums] else { return [] }
            for result in results {
                guard let artist = result.artist, let name = result.name, let imageData = result.image, let image = UIImage(data: imageData) else { return [] }
                let emptyElement = AlbumDataStructure(artist: artist, image: image, name: name)
                fetchedTableData.append(emptyElement)
            }
        } catch {
            print(error)
        }
        return fetchedTableData
    }
    
    func localStorageSaveAlbums(artist: String, image: UIImage, name: String) {
        //store albums to DB
        var managedObject: [Albums] = []
        let emptyElement = Albums()
        emptyElement.artist = artist
        emptyElement.image = image.pngData()
        emptyElement.name = name
        managedObject.append(emptyElement)
        CoreDataManager.instance.saveContext()
        
    }
    
    func fetchDataFromTracksDB() -> [TracksDataStructure] {
        //fetch tracks method
        var fetchedTableData: [TracksDataStructure] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracks")
        do {
            guard let results = try CoreDataManager.instance.managedObjectContext.fetch(fetchRequest) as? [Tracks] else { return [] }
            for result in results {
                guard let name = result.name else { return [] }
                let emptyElement = TracksDataStructure(name: name)
                fetchedTableData.append(emptyElement)
            }
        } catch {
            print(error)
        }
        return fetchedTableData
    }
    
    func localStorageSaveTracks(name: String) {
        //store tracks in DB
        var managedObject: [Tracks] = []
        let emptyElement = Tracks()
        emptyElement.name = name
        managedObject.append(emptyElement)
        CoreDataManager.instance.saveContext()
        
    }
    
    func structureToObject(data: AlbumDataStructure) -> Albums
    {
        let resultValue = Albums()
        resultValue.name = data.name
        resultValue.image = data.image.pngData()
        resultValue.artist = data.artist
        return resultValue
    }
}
