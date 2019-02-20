//
//  SearchAlbumDetailsAPIModel.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class SearchAlbumDetailsAPIModel: Codable {
    
    let album: Album?
    
    enum CodingKeys: String, CodingKey {
        case album
    }
    init(album: Album?) {
        
        self.album = album
    }
}
