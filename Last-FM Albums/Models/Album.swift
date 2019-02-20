//
//  Album.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class Album: Codable {
    
    let artist: String?
    let image: [Image]?
    let name: String?
    let tracks: Track?
    
    enum CodingKeys: String, CodingKey {
        case artist = "artist"
        case image = "image"
        case name = "name"
        case tracks
    }
    init(artist: String?, image: [Image]?, name: String?, tracks: Track?) {
        
        self.artist = artist
        self.image = image
        self.name = name
        self.tracks = tracks
    }
}
