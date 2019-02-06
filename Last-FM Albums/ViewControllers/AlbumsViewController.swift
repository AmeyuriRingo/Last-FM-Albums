//
//  AlbumsViewController.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    private let cellReuseIdentifier = "albumCell"
    private var albums: [String]?
    private var saveData = SaveData()
    
    var artistName: String?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        reloadTableData()
        table.delegate = self
        table.dataSource = self
        guard let text = artistName else { return }
        let textForRequest = text.replacingOccurrences(of: " ", with: "+")
        SearchForArtistsAlbums.search(nameOfArtist: textForRequest) { albums in
            
            self.albums = albums
            self.table.reloadData()
            self.activityIndicator.stopAnimating()
        }
            
    }
    
    @IBAction func saveToLocalStorage(_ sender: UIButton) {
        
        if let artistIndex = table.indexPathForSelectedRow?.row {
            guard let name = artistName, let album = albums?[artistIndex] else { return }
            let nameForRequest = name.replacingOccurrences(of: " ", with: "+")
            let albumForRequest = album.replacingOccurrences(of: " ", with: "+")
            SearchForArtistsAlbums.searchAlbumDetails(nameOfArtist: nameForRequest, nameOfAlbum: albumForRequest) { albumName, albumArtist, tracks, imageURL in
                
                guard let artist = albumArtist, let name = albumName, let track = tracks else { return }
                //self.saveData.localStorageSave(artist: artist, image: <#T##UIImage#>, name: name, tracks: track)
            }
        }
    }
        func reloadTableData() {
        
        table.reloadData()
    }
}
extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let numberOfRows = albums?.count else { return 0 }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? AlbumCell else { return UITableViewCell() }
        //put our album names into cell of table
        cell.albumName.text = self.albums?[indexPath.row]
        return cell
    }
}
