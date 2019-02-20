//
//  AlbumsViewController.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    private let cellReuseIdentifier = "albumCell"
    private let detailSegueIdentifier = "showDetailSegue"
    private var albums: [AlbumName]?
    private let network = Network()
    
    var artistName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting albims list from server
        network.artistAlbumsDelegate = self
        activityIndicator.startAnimating()
        guard let text = artistName else { return }
        let textForRequest = text.replacingOccurrences(of: " ", with: "+")
        network.artistsAlbums(nameOfArtist: textForRequest)
        table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send albuns info to detailScreen
        if segue.identifier == detailSegueIdentifier, let destination = segue.destination as? DetailViewController,
            let albumIndex = table.indexPathForSelectedRow?.row {
            destination.albumsName = albums?[albumIndex].name
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
        cell.albumName.text = self.albums?[indexPath.row].name
        return cell
    }
}

extension AlbumsViewController: ArtistAlbumsDelegate {
    
    func loadDataCompleted(albumList: SearchAlbumAPIModel) {
        
        var i = 0
        guard var album = albumList.topalbums?.album else { return }
        for existingName in album {
            
            if existingName.name == "(null)" {
                
                album.remove(at: i)
                i -= 1
            }
            i += 1
        }
        self.albums = album
        table.reloadData()
        activityIndicator.stopAnimating()
    }
}
