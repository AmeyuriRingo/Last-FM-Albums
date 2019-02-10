//
//  SearchViewController.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/1/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    private let cellReuseIdentifier = "artistCell"
    private var artists: [String]?
    private let albumsSegueIdentifier = "showAlbumsSegue"
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searheArtistTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searheArtistTextField.delegate = self
    }

    @IBAction func refresTableData(_ sender: UIBarButtonItem) {
        //sends a request to server and reload the table
        activityIndicator.startAnimating()
        guard let text = searheArtistTextField.text else { return }
        let textForRequest = text.replacingOccurrences(of: " ", with: "+")
        Search.forArtist(nameOfArtist: textForRequest) { names in
            
            self.artists = names
            self.table.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    //hide keyboard method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return true
    }
    //sends name of artist to AlbumsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == albumsSegueIdentifier, let destination = segue.destination as? AlbumsViewController,
            let artistIndex = table.indexPathForSelectedRow?.row {
            destination.artistName = artists?[artistIndex]
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of cells
        return artists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ArtistCell else { return UITableViewCell() }
        //put our artists names into cell of table
        cell.artistName.text = self.artists?[indexPath.row]
        return cell
    }
}
