//
//  SearchForArtist.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class SearchForArtist {
    
    static func search(nameOfArtist: String, completion: @escaping ([String]?) -> Void) {
        //request to Last-FM to get list of artists
        Alamofire.request("http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=\(nameOfArtist)&api_key=bad5acca27008a09709ccb2c0258003b&format=json")
            .responseObject { (response: DataResponse<SearchArtistAPIModel>) in
                //decode JSON from server to object
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
