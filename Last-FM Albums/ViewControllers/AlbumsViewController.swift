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
    
    var artistName: String?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting albims list from server
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
    
    func reloadTableData() {
        
        table.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //send albuns info to detailScreen
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
