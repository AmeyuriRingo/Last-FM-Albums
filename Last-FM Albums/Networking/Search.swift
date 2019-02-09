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
        //request to Last-FM to get list of artists
        Alamofire.request("http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json")
            .responseObject { (response: DataResponse<SearchArtistAPIModel>) in
                //decode JSON from server to object
//                guard case let .failure(error) = response.result else { return }
//
//                if let error = error as? AFError {
//                    switch error {
//                    case .invalidURL(let url):
//                        print("Invalid URL: \(url) - \(error.localizedDescription)")
//                    case .parameterEncodingFailed(let reason):
//                        print("Parameter encoding failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    case .multipartEncodingFailed(let reason):
//                        print("Multipart encoding failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    case .responseValidationFailed(let reason):
//                        print("Response validation failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//
//                        switch reason {
//                        case .dataFileNil, .dataFileReadFailed:
//                            print("Downloaded file could not be read")
//                        case .missingContentType(let acceptableContentTypes):
//                            print("Content Type Missing: \(acceptableContentTypes)")
//                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
//                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
//                        case .unacceptableStatusCode(let code):
//                            print("Response status code was unacceptable: \(code)")
//                        }
//                    case .responseSerializationFailed(let reason):
//                        print("Response serialization failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    }
//
//                    print("Underlying error: \(String(describing: error.underlyingError))")
//                } else if let error = error as? URLError {
//                    print("URLError occurred: \(error)")
//                } else {
//                    print("Unknown error: \(error)")
//                }

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
    
    static func forArtistsAlbums(nameOfArtist: String, completion: @escaping ([String]?) -> Void) {
        
        Alamofire.request("http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json")
            .responseObject { (response: DataResponse<SearchAlbumAPIModel>) in
                
//                guard case let .failure(error) = response.result else { return }
//
//                if let error = error as? AFError {
//                    switch error {
//                    case .invalidURL(let url):
//                        print("Invalid URL: \(url) - \(error.localizedDescription)")
//                    case .parameterEncodingFailed(let reason):
//                        print("Parameter encoding failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    case .multipartEncodingFailed(let reason):
//                        print("Multipart encoding failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    case .responseValidationFailed(let reason):
//                        print("Response validation failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//
//                        switch reason {
//                        case .dataFileNil, .dataFileReadFailed:
//                            print("Downloaded file could not be read")
//                        case .missingContentType(let acceptableContentTypes):
//                            print("Content Type Missing: \(acceptableContentTypes)")
//                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
//                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
//                        case .unacceptableStatusCode(let code):
//                            print("Response status code was unacceptable: \(code)")
//                        }
//                    case .responseSerializationFailed(let reason):
//                        print("Response serialization failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    }
//
//                    print("Underlying error: \(error.underlyingError)")
//                } else if let error = error as? URLError {
//                    print("URLError occurred: \(error)")
//                } else {
//                    print("Unknown error: \(error)")
//                }
                
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
    
    static func forAlbumDetails(nameOfArtist: String, nameOfAlbum: String, completion: @escaping (String?, String?, [String]?, String?) -> Void) {
        
        Alamofire.request("http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=bad5acca27008a09709ccb2c0258003b&artist=\(nameOfArtist)&album=\(nameOfAlbum)&format=json")
            .responseObject { (response: DataResponse<SearchAlbumDetailsAPIModel>) in
                
//                guard case let .failure(error) = response.result else { return }
//
//                if let error = error as? AFError {
//                    switch error {
//                    case .invalidURL(let url):
//                        print("Invalid URL: \(url) - \(error.localizedDescription)")
//                    case .parameterEncodingFailed(let reason):
//                        print("Parameter encoding failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    case .multipartEncodingFailed(let reason):
//                        print("Multipart encoding failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    case .responseValidationFailed(let reason):
//                        print("Response validation failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//
//                        switch reason {
//                        case .dataFileNil, .dataFileReadFailed:
//                            print("Downloaded file could not be read")
//                        case .missingContentType(let acceptableContentTypes):
//                            print("Content Type Missing: \(acceptableContentTypes)")
//                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
//                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
//                        case .unacceptableStatusCode(let code):
//                            print("Response status code was unacceptable: \(code)")
//                        }
//                    case .responseSerializationFailed(let reason):
//                        print("Response serialization failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    }
//
//                    print("Underlying error: \(error.underlyingError)")
//                } else if let error = error as? URLError {
//                    print("URLError occurred: \(error)")
//                } else {
//                    print("Unknown error: \(error)")
//                }
                
                if let albumDetails = response.result.value {
                    //debugPrint(albumDetails)
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
    
    static func getImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
        
        Alamofire.request(imageURL)
            .responseImage { response in
                
//                guard case let .failure(error) = response.result else { return }
//                
//                if let error = error as? AFError {
//                    switch error {
//                    case .invalidURL(let url):
//                        print("Invalid URL: \(url) - \(error.localizedDescription)")
//                    case .parameterEncodingFailed(let reason):
//                        print("Parameter encoding failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    case .multipartEncodingFailed(let reason):
//                        print("Multipart encoding failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    case .responseValidationFailed(let reason):
//                        print("Response validation failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                        
//                        switch reason {
//                        case .dataFileNil, .dataFileReadFailed:
//                            print("Downloaded file could not be read")
//                        case .missingContentType(let acceptableContentTypes):
//                            print("Content Type Missing: \(acceptableContentTypes)")
//                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
//                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
//                        case .unacceptableStatusCode(let code):
//                            print("Response status code was unacceptable: \(code)")
//                        }
//                    case .responseSerializationFailed(let reason):
//                        print("Response serialization failed: \(error.localizedDescription)")
//                        print("Failure Reason: \(reason)")
//                    }
//                    
//                    print("Underlying error: \(error.underlyingError)")
//                } else if let error = error as? URLError {
//                    print("URLError occurred: \(error)")
//                } else {
//                    print("Unknown error: \(error)")
//                }
                
                if let image = response.result.value {
                    completion(image)
                }
        }
    }
}
