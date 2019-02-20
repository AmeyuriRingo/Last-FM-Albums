//
//  DetailViewController.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var trackList: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var saveData = SaveData()
    private var data: [AlbumDataStructure] = []
    private let network = Network()
    private var imageString: String?
    
    var albumsName: String?
    var artistsName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get all detail about album and present on view
        setDataToVC()
        getDetailInfo()
        network.albumsDetailDelegate = self
    }
    
    func getDetailInfo() {
        
        activityIndicator.startAnimating()
        guard let name = artistsName, let album = albumsName else { return }
        let nameForRequest = name.replacingOccurrences(of: " ", with: "+")
        let albumForRequest = album.replacingOccurrences(of: " ", with: "+")
        network.albumDetails(nameOfArtist: nameForRequest, nameOfAlbum: albumForRequest)
        
    }
    func setDataToVC() {
        
        data = saveData.fetchDataFromAlbumsDB()
    }
    
    @IBAction func saveToDB(_ sender: Any) {
        //save detail info about album to DB
        guard let artist = artist.text, let image = albumImage.image, let name = albumsName, let tracks = trackList.text else { return }
        self.saveData.localStorageSaveAlbums(artist: artist, image: image, name: name)
        self.saveData.localStorageSaveTracks(name: tracks)
        
    }
    
    @IBAction func deleteFromDB(_ sender: Any) {
        
        //guard let artist = artist.text, let image = albumImage.image, let name = albumsName, let tracks = trackList.text else { return }
        //        let albumObjc = saveData.structureToObject(artist: artist, image: image, name: name)
        //        CoreDataManager.instance.deleteObject(albumObjc)
        
        //        let context = CoreDataManager.instance.managedObjectContext
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Albums")
        //        if let result = try? context.fetch(fetchRequest) {
        //            for object in result {
        //                context.delete(object)
        //            }
        //        }
        
        //        let context = CoreDataManager.instance.persistentContainer.viewContext
        //        let newAlbum = NSEntityDescription.insertNewObject(forEntityName: "Albums", into: context)
        //        newAlbum.setValue(artist, forKey: "artist")
        //        newAlbum.setValue(image, forKey: "image")
        //        newAlbum.setValue(name, forKey: "name")
        //context.delete(albumObjc)
        //        CoreDataManager.instance.saveContext()
        
        //        do {
        //
        //        try context.save()
        //        } catch {
        //            print("Error")
        //        }
    }
    
}

extension DetailViewController: AlbumsDetailDelegate {
    
    func loadDataCompleted(detailList: SearchAlbumDetailsAPIModel) {
        
        self.albumName.text = detailList.album?.name
        self.artist.text = detailList.album?.artist
        var tracks: [String] = []
        var imageForURL: String?
        guard let tracksArray = detailList.album?.tracks?.track, let imagesArray = detailList.album?.image else { return }
        for track in tracksArray {
            
            guard let trackName = track.name else { return }
            tracks.append(trackName)
        }
        if (tracks != []) {
            
            self.trackList.text = tracks.joined(separator: "\n")
        } else {
            
            self.trackList.text = "This album still empty =)"
        }
        for image in imagesArray {
            
            guard let imageSize = image.size, let imageString = image.text else { return }
            if imageSize == "large" {
                
                imageForURL = imageString
            }
        }
        self.imageString = imageForURL
        guard let url = imageString else { return }
        if let url = URL(string: url) {
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: {(data, _, error) -> Void in
                if error != nil {
                    print("some error!")
                } else {
                    if let bach = UIImage(data: data!) {
                        
                        DispatchQueue.main.async {
                            
                            self.albumImage.image = bach
                        }
                    }
                }
            })
            task.resume()
        }
        self.activityIndicator.stopAnimating()
    }
}
