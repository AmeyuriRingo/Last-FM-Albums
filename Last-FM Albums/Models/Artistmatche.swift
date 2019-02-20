//
//  Artistmatche.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class ArtistMatches: Codable {
    
    let artist: [Artist]?
    
    enum CodingKeys: String, CodingKey {
     
        case artist = "artist"
    }
    init(artist: [Artist]?) {
        
        self.artist = artist
    }
}
