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
    private var imagesURL: [String]?
    private let albumsSegueIdentifier = "showAlbumsSegue"
    private var searchText: String?
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        
        return searchController.isActive && !searchBarIsEmpty
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchControllerSetUp()
    }
    //search controller declaration
    func searchControllerSetUp() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter name of artist"
        searchController.hidesNavigationBarDuringPresentation =
        false
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //updating search results after entering two characters
        let search = Search()
        guard let searchCharNumber = searchController.searchBar.text?.count else { return }
        if searchCharNumber > 2 {
            
            guard let searchBarText = searchController.searchBar.text else { return }
            searchText = searchBarText
            activityIndicator.startAnimating()
            guard let text = searchText else { return }
            let textForRequest = text.replacingOccurrences(of: " ", with: "+")
            search.searchForArtist(nameOfArtist: textForRequest)
            //            Search.forArtist(nameOfArtist: textForRequest) { names in
            //
            //                //                    self.artists?.append("No artists found")
            //                //                    self.table.reloadData()
            //                //                    self.activityIndicator.stopAnimating()
            //                //                    Alert.alert(errorText: "No artists found")
            //                self.artists = names
            //                self.activityIndicator.stopAnimating()
            //                self.table.reloadData()
            //            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of cells
        if isFiltering {
            
            return artists?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ArtistCell else { return UITableViewCell() }
        //put our artists names into cell of table
        if isFiltering {
            
            cell.artistName.text = self.artists?[indexPath.row]
        }
        
        return cell
    }
}

extension SearchViewController: SearchArtistDelegate {
        
    func loadDataCompleted(names: [String], images: [Image]) {
        artists = names
        images.forEach(
            {element in
                if let urlString = element.text
                {
                    let url = URL(string: urlString)
                    
                }
        }
        )
        self.artists = names
        self.activityIndicator.stopAnimating()
        self.table.reloadData()
    }
}
