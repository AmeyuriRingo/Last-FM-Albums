////
////  SearchForArtist.swift
////  Last-FM Albums
////
////  Created by Ringo_02 on 2/6/19.
////  Copyright © 2019 Ringo_02. All rights reserved.
////
//
import Foundation
//один метод через generic - переиспользование кода
protocol SearchArtistDelegate: class {
    
    func loadDataCompleted(artistList: SearchArtistAPIModel)
}
protocol ArtistAlbumsDelegate: class {
    
    func loadDataCompleted(albumList: SearchAlbumAPIModel)
}

protocol AlbumsDetailDelegate: class {
    
    func loadDataCompleted(detailList: SearchAlbumDetailsAPIModel)
}
class Network {
    
    weak var searchArtistDelegate: SearchArtistDelegate?
    weak var artistAlbumsDelegate: ArtistAlbumsDelegate?
    weak var albumsDetailDelegate: AlbumsDetailDelegate?
    
    func searchForArtist(nameOfArtist: String) {
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {data, _, error in
                guard error == nil else {
                    
                    debugPrint("error")
                    return
                }
                guard let data = data else {
                    
                    debugPrint("data")
                    return
                }
                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let artistList = try jsonDecoder.decode(SearchArtistAPIModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.searchArtistDelegate?.loadDataCompleted(artistList: artistList)
                    }
                } catch let error {
                    
                    debugPrint(debugPrint(error.localizedDescription))
                }
            })
            task.resume()
        }
    }
    //completionHandler
    func artistsAlbums(nameOfArtist: String) {
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {data, _, error in
                guard error == nil else {
                    
                    debugPrint("error")
                    return
                }
                guard let data = data else {
                    
                    debugPrint("data")
                    return
                }
                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let albumList = try jsonDecoder.decode(SearchAlbumAPIModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.artistAlbumsDelegate?.loadDataCompleted(albumList: albumList)
                    }
                } catch let error {
                    
                    debugPrint(debugPrint(error.localizedDescription))
                }
            })
            task.resume()
        }
    }
    
    func albumDetails(nameOfArtist: String, nameOfAlbum: String) {
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=bad5acca27008a09709ccb2c0258003b&artist=\(nameOfArtist)&album=\(nameOfAlbum)&format=json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {data, _, error in
                guard error == nil else {
                    
                    debugPrint("error")
                    return
                }
                guard let data = data else {
                    
                    debugPrint("data")
                    return
                }
                do {
                    
                    let jsonDecoder = JSONDecoder()
                    let detailList = try jsonDecoder.decode(SearchAlbumDetailsAPIModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        
                        self.albumsDetailDelegate?.loadDataCompleted(detailList: detailList)
                    }
                } catch let error {
                    
                    debugPrint(debugPrint(error.localizedDescription))
                }
            })
            task.resume()
        }
    }
}
