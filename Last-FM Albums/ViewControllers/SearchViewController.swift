//
//  SearchViewController.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/1/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import CodableAlamofire

class SearchViewController: UIViewController {
    
    private let cellReuseIdentifier = "artistCell"
    private var artists: [String]?
    private let albumsSegueIdentifier = "ShowAlbumsSegue"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searheArtistTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
    }
    
    func reloadTableData() {
        //updates teble data
        table.reloadData()
    }
    @IBAction func refresTableData(_ sender: UIBarButtonItem) {
        //sends a reauest to server and reload the table
        activityIndicator.startAnimating()
        guard let text = searheArtistTextField.text else { return }
        let textForRequest = text.replacingOccurrences(of: " ", with: "+")
        SearchForArtist.search(nameOfArtist: textForRequest) { names in
            
            self.artists = names
            self.table.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == albumsSegueIdentifier, let destination = segue.destination as? AlbumsViewController,
            let artistIndex = table.indexPathForSelectedRow?.row {
            destination.artistName = artists?[artistIndex]
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of cells
        guard let numberOfRows = artists?.count else { return 0 }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ArtistCell else { return UITableViewCell() }
        //put our artists names into cell of table
        cell.artistName.text = self.artists?[indexPath.row]
        return cell
    }
}
