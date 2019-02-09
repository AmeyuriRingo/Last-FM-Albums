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
    private let detailSegueIdentifier = "showDetailSegue"
    private var albums: [String]?
    private var saveData = SaveData()
    
    var artistName: String?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        table.delegate = self
        table.dataSource = self
        guard let text = artistName else { return }
        let textForRequest = text.replacingOccurrences(of: " ", with: "+")
        Search.forArtistsAlbums(nameOfArtist: textForRequest) { albums in
            
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
            Search.forAlbumDetails(nameOfArtist: nameForRequest, nameOfAlbum: albumForRequest) { albumName, albumArtist, tracks, imageURL in

                    guard let artist = albumArtist, let imageString = imageURL, let name = albumName, let track = tracks else { return }
                Search.getImage(imageURL: imageString) { image in
                    guard let albumImage = image else { return }
                    self.saveData.localStorageSave(artist: artist, image: albumImage, name: name)
                }
            }
        }
    }
        func reloadTableData() {
        
        table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegueIdentifier, let destination = segue.destination as? DetailViewController,
            let albumIndex = table.indexPathForSelectedRow?.row {
            destination.albumsName = albums?[albumIndex]
            destination.artistsName = artistName
        }
    }
    
}
extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? AlbumCell else { return UITableViewCell() }
        //put our album names into cell of table
        cell.albumName.text = self.albums?[indexPath.row]
        return cell
    }
}
