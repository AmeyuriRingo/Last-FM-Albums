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
    
    private var saveData = SaveData()
    private var data: [AlbumDataStructure] = []
    
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var trackList: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var albumsName: String?
    var artistsName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get all detail about album and present on view
        setDataToVC()
        activityIndicator.startAnimating()
        guard let name = artistsName, let album = albumsName else { return }
        let nameForRequest = name.replacingOccurrences(of: " ", with: "+")
        let albumForRequest = album.replacingOccurrences(of: " ", with: "+")
        Search.forAlbumDetails(nameOfArtist: nameForRequest, nameOfAlbum: albumForRequest) { albumName, albumArtist, tracks, imageURL in
            
            guard let artist = albumArtist, let imageString = imageURL, let name = albumName, let track = tracks else { return }
            
            self.albumName.text = name
            self.artist.text = artist
            self.trackList.text = track.joined(separator: "\n")
            
            Search.getImage(imageURL: imageString) { image in
                guard let albumImages = image else { return }
                self.albumImage.image = albumImages
                self.activityIndicator.stopAnimating()
            }
        }
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
}
