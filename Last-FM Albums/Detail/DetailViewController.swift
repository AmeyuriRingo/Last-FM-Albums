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
    @IBOutlet weak var tracksLanel: UILabel!
    @IBOutlet weak var stateButton: UIBarButtonItem!
    
    private var saveData = SaveData()
    private var data: [AlbumDataStructure] = []
    private let network = Network()
    private var imageString: String?
    private var album: [Albums] = []
    
    var albumsName: String?
    var artistsName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get all detail about album and present on view
        setDataToVC()
        getDetailInfo()
        checkButtonState()
        network.albumsDetailDelegate = self
    }
    
    func checkButtonState() {
        
        guard let name = albumsName else { return }
        
        let context = CoreDataManager.instance.managedObjectContext
        let fetchRequest = NSFetchRequest<Albums>(entityName: "Albums")
        if let result = try? context.fetch(fetchRequest) {
            if result.isEmpty {
                
                stateButton.title = "Save"
            } else {
                
                stateButton.title = "Delete"
                for object in result {
                    
                    album.append(object)
                }
            }
        }
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
        //save and delete detail info about album to DB
        if album.isEmpty {
            guard let artist = artist.text, let image = albumImage.image, let name = albumsName, let tracks = trackList.text else { return }
            self.saveData.localStorageSaveAlbums(artist: artist, image: image, name: name)
            self.saveData.localStorageSaveTracks(name: tracks)
            stateButton.title = "Delete"
        } else {
            
            CoreDataManager.instance.deleteObject(album[0])
            CoreDataManager.instance.saveContext()
            stateButton.title = "Save"
        }
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
