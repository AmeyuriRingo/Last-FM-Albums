//
//  SearchForArtist.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class Search {
    
    static func forArtist(nameOfArtist: String, completion: @escaping ([String]?) -> Void) {
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            Alamofire.request(url).validate()
                .responseObject { (response: DataResponse<SearchArtistAPIModel>) in
                    //to get status code
                    debugPrint(response)
                    if let status = response.response?.statusCode {
                        
                        switch(status) {
                            
                        case 200...299:
                            print("example success")
                        default:
                            print("error with response status: \(status)")
                        }
                    }
                    
                    if let artistName = response.result.value {
                        
                        guard let artistsArray = artistName.results?.artistmatches?.artist else { return }
                        var names: [String] = []
                        for artists in artistsArray {
                            guard let artistsName = artists.name else { return }
                            names.append(artistsName)
                            completion(names)
                        }
                    }
            }
        }
    }
    
    static func forArtistsAlbums(nameOfArtist: String, completion: @escaping ([String]?) -> Void) {
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            Alamofire.request(url).validate()
                .responseObject { (response: DataResponse<SearchAlbumAPIModel>) in
                    //request for receiving albums of artist from the server
                    if let albumName = response.result.value {
                        
                        if let status = response.response?.statusCode {
                            
                            switch(status) {
                                
                            case 200...299:
                                print("example success")
                            default:
                                print("error with response status: \(status)")
                            }
                        }
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
    }
    
    static func forAlbumDetails(nameOfArtist: String, nameOfAlbum: String, completion: @escaping (String?, String?, [String]?, String?) -> Void) {
        //request for receiving detail info about albums from the server
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=bad5acca27008a09709ccb2c0258003b&artist=\(nameOfArtist)&album=\(nameOfAlbum)&format=json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            Alamofire.request(url).validate()
                .responseObject { (response: DataResponse<SearchAlbumDetailsAPIModel>) in
                    
                    if let status = response.response?.statusCode {
                        
                        switch(status) {
                            
                        case 200...299:
                            print("example success")
                        default:
                            print("error with response status: \(status)")
                        }
                    }
                    
                    if let albumDetails = response.result.value {
                        
                        guard let albumName = albumDetails.album?.name, let albumArtist = albumDetails.album?.artist, let albumTracks = albumDetails.album?.tracks?.track, let albumImage = albumDetails.album?.image else { return }
                        var tracks: [String] = []
                        var imageURL: String = ""
                        for allTracks in albumTracks {
                            
                            guard let trackName = allTracks.name else { return }
                            tracks.append(trackName)
                        }
                        for image in albumImage where image.size == "large" {
                            
                            guard let largeImage = image.text else { return }
                            imageURL = largeImage
                        }
                        completion(albumName, albumArtist, tracks, imageURL)
                    }
            }
        }
    }
    static func getImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
        //getting image from server by sending URL of image
        Alamofire.request(imageURL)
            .responseImage { response in
                
                if let status = response.response?.statusCode {
                    
                    switch(status) {
                        
                    case 200...299:
                        print("success")
                    default:
                        print("error with response status: \(status)")
                    }
                }
                if let image = response.result.value {
                    completion(image)
                }
        }
    }
}
