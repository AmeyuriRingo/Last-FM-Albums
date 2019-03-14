//
//  Topalbum.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class TopAlbum: Codable {
    
    let album: [AlbumName]?
    
    enum CodingKeys: String, CodingKey {
        
        case album = "album"
    }
    init(album: [AlbumName]?) {
        
        self.album = album
    }
}
