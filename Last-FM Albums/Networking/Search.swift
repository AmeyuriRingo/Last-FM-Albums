////
////  SearchForArtist.swift
////  Last-FM Albums
////
////  Created by Ringo_02 on 2/6/19.
////  Copyright © 2019 Ringo_02. All rights reserved.
////
//
import Foundation

protocol SearchArtistDelegate: class {
    
    func loadDataCompleted(names: [String], images: [Image])
}
//class network
class Search {
    
    weak var delegate: SearchArtistDelegate?
    
    func searchForArtist(nameOfArtist: String) {
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json"
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        var fullLoadedData = [Artist]()
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
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
                let artist = try jsonDecoder.decode(Artist.self, from: data)
                var names: [String] = []
                var images: [Image] = []
                guard let artistName = artist.name, let artistImage = artist.image else { return }
                for index in 0..<artistImage.count
                {
                    if (artistImage[index].size == "small")
                    {
                        images.append(artistImage[index])
                    }
                }
                names.append(artistName)
                
                DispatchQueue.main.async {
                    
                    self.delegate?.loadDataCompleted(names: names, images: images)
                    
                }
            } catch let error {
                debugPrint(debugPrint(error.localizedDescription))
            }
            
        })
        
        task.resume()
        }
    }
    //    //    typealias JSONDictionary = [String: Any]
    //    //    typealias QueryResult = ([Album]?, String) -> ()
    //    //
    //    //    private var albums: [Album] = []
    //    //    private var errorMessage = ""
    //    //    private let defaultSession = URLSession(configuration: .default)
    //    //    private var dataTask: URLSessionDataTask?
    //    //
    //    //    static func getArtists(with name: String, page: Int = 1, completion: @escaping (Result<[Artist]?>) -> Void) {
    //    //
    //    //        guard let request = MutableURL else { return }
    //    //
    //    //        URLSession.shared.dataTask(with: request) { data, _, error in
    //    //            if let data = data {
    //    //                do {
    //    //                    let root = try JSONDecoder().decode(ArtistsRoot.self, from: data)
    //    //                    completion(.success(root.artists))
    //    //                } catch {
    //    //                    completion(.failure(error))
    //    //                }
    //    //            }
    //    //
    //    //            if let error = error {
    //    //                completion(.failure(error))
    //    //            }
    //    //            }.resume()
    //    //    }
    //
    //
    //    //    static func forArtist(nameOfArtist: String, completion: @escaping ([String]?) -> Void) {
    //
    //    //        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json"
    //    //        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
    //    //            Alamofire.request(url).validate()
    //    //                .responseObject { (response: DataResponse<SearchArtistAPIModel>) in
    //    //                    //to get status code
    //    //                    debugPrint(response)
    //    //                    if let status = response.response?.statusCode {
    //    //
    //    //                        switch(status) {
    //    //
    //    //                        case 200...299:
    //    //                            print("example success")
    //    //                        default:
    //    //                            print("error with response status: \(status)")
    //    //                        }
    //    //                    }
    //    //
    //    //                    if let artistName = response.result.value {
    //    //
    //    //                        guard let artistsArray = artistName.results?.artistmatches?.artist else { return }
    //    //                        var names: [String] = []
    //    //                        for artists in artistsArray {
    //    //                            guard let artistsName = artists.name else { return }
    //    //                            names.append(artistsName)
    //    //                            completion(names)
    //    //                        }
    //    //                    }
    //    //            }
    //    //        }
    //    //    }
    //
    //    static func forArtistsAlbums(nameOfArtist: String, completion: @escaping ([String]?) -> Void) {
    //
    //        let urlString = "http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json"
    //        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
    //            Alamofire.request(url).validate()
    //                .responseObject { (response: DataResponse<SearchAlbumAPIModel>) in
    //                    //request for receiving albums of artist from the server
    //                    if let albumName = response.result.value {
    //
    //                        if let status = response.response?.statusCode {
    //
    //                            switch(status) {
    //
    //                            case 200...299:
    //                                print("example success")
    //                            default:
    //                                print("error with response status: \(status)")
    //                            }
    //                        }
    //                        guard let albumsArray = albumName.topalbums?.album else { return }
    //                        var names: [String] = []
    //                        for albums in albumsArray {
    //                            guard let albumsName = albums.name else { return }
    //                            names.append(albumsName)
    //                            completion(names)
    //                        }
    //                    }
    //            }
    //        }
    //    }
    //
    //    static func forAlbumDetails(nameOfArtist: String, nameOfAlbum: String, completion: @escaping (String?, String?, [String]?, String?) -> Void) {
    //        //request for receiving detail info about albums from the server
    //        let urlString = "http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=bad5acca27008a09709ccb2c0258003b&artist=\(nameOfArtist)&album=\(nameOfAlbum)&format=json"
    //        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
    //            Alamofire.request(url).validate()
    //                .responseObject { (response: DataResponse<SearchAlbumDetailsAPIModel>) in
    //
    //                    if let status = response.response?.statusCode {
    //
    //                        switch(status) {
    //
    //                        case 200...299:
    //                            print("example success")
    //                        default:
    //                            print("error with response status: \(status)")
    //                        }
    //                    }
    //
    //                    if let albumDetails = response.result.value {
    //
    //                        guard let albumName = albumDetails.album?.name, let albumArtist = albumDetails.album?.artist, let albumTracks = albumDetails.album?.tracks?.track, let albumImage = albumDetails.album?.image else { return }
    //                        var tracks: [String] = []
    //                        var imageURL: String = ""
    //                        for allTracks in albumTracks {
    //
    //                            guard let trackName = allTracks.name else { return }
    //                            tracks.append(trackName)
    //                        }
    //                        for image in albumImage where image.size == "large" {
    //
    //                            guard let largeImage = image.text else { return }
    //                            imageURL = largeImage
    //                        }
    //                        completion(albumName, albumArtist, tracks, imageURL)
    //                    }
    //            }
    //        }
    //    }
    //    static func getImage(imageURL: String, completion: @escaping (UIImage?) -> Void) {
    //        //getting image from server by sending URL of image
    //        Alamofire.request(imageURL)
    //            .responseImage { response in
    //
    //                if let status = response.response?.statusCode {
    //
    //                    switch(status) {
    //
    //                    case 200...299:
    //                        print("success")
    //                    default:
    //                        print("error with response status: \(status)")
    //                    }
    //                }
    //                if let image = response.result.value {
    //                    completion(image)
    //                }
    //        }
    //}
    //
    ////    fileprivate func updateSearchResults(_ data: Data) {
    ////
    ////        var response: JSONDictionary?
    ////        albums.removeAll()
    ////
    ////        do {
    ////
    ////            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    ////        } catch let parseError as NSError {
    ////
    ////            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
    ////            return
    ////        }
    ////
    ////        guard let array = response!["results"] as? [Any] else {
    ////
    ////            errorMessage += "Dictionary does not contain results key\n"
    ////            return
    ////        }
    ////        var index = 0
    ////        for trackDictionary in array {
    ////            if let trackDictionary = trackDictionary as? JSONDictionary,
    ////                let name = trackDictionary["name"] as? String {
    ////
    ////                albums.append(Album(name: name))
    ////                index += 1
    ////            } else {
    ////
    ////                errorMessage += "Problem parsing trackDictionary\n"
    ////            }
    ////        }
    ////    }
}
