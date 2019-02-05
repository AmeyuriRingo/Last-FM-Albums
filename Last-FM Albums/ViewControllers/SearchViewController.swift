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
    
    private let cellReuseIdentifier = "cell"
    private var artists: [String]?
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searheArtistTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadTableData()
        table.delegate = self
        table.dataSource = self
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func reloadTableData() {
        
        table.reloadData()
    }
        @IBAction func refresTableData(_ sender: UIBarButtonItem) {
            //sends a reauest to server and reload the table
            guard let text = searheArtistTextField.text else { return }
        searchArtist(name: text) { names in

            self.artists = names
            self.table.reloadData()
        }
        
    }

    func searchArtist(name: String, completion: @escaping ([String]?) -> Void) {
        //request to Last-FM to get list of artists
        Alamofire.request("http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(name)&api_key=bad5acca27008a09709ccb2c0258003b&format=json")
            .responseObject { (response: DataResponse<SearchArtistAPIModel>) in
                //decode JSON from server to object
                if let artistName = response.result.value {
                    guard let artistsArray = artistName.results?.artistmatches?.artist else { return }
                    var names: [String] = []
                    for artists in artistsArray {
                        names.append(artists.name ?? "")
                        debugPrint(names)
                        //self.reloadTableData()
                        completion(names)
                    }
                }
        }
        //reloadTableData()
    }
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
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
