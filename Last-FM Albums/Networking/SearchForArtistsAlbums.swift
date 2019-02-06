//
//  SearchForArtistsALbumsswift.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class SearchForArtistsAlbums {
    
    static func search(nameOfArtist: String, completion: @escaping ([String]?) -> Void) {
        
        Alamofire.request("http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json")
            .responseObject { (response: DataResponse<SearchAlbumAPIModel>) in
                
                if let albumName = response.result.value {
                    
                    guard let albumsArray = albumName.topalbums?.album else { return }
                    var names: [String] = []
                    for albums in albumsArray {
                        guard let albumsName = albums.name else { return }
                        names.append(albumsName)
                        completion(names)
                    }
                }
        }
    }
    
    static func searchAlbumDetails(nameOfArtist: String, nameOfAlbum: String, completion: @escaping (String?, String?, [String]?, String?) -> Void) {
        
        Alamofire.request("http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=YOUR_API_KEY&artist=\(nameOfArtist)&album=\(nameOfAlbum)&format=json")
            .responseObject { (response: DataResponse<SearchAlbumDetailsAPIModel>) in
                
                if let albumDetails = response.result.value {
                    guard let albumName = albumDetails.album?.name, let albumArtist = albumDetails.album?.artist, let albumTracks = albumDetails.album?.tracks?.track, let albumImage = albumDetails.album?.image else { return }
                    var tracks: [String] = []
                    var imageURL: String = ""
                    for allTracks in albumTracks {
                        guard let trackName = allTracks.name else { return }
                        tracks.append(trackName)
                    }
                    for image in albumImage {
                        if image.size == "large" {
                            guard let largeImage = image.text else { return }
                            imageURL = largeImage
                        }
                    }
                    completion(albumName, albumArtist, tracks, imageURL)
                }
        }
    }
}
