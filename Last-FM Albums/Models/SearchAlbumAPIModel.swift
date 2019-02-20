//
//  SearchAlbumAPIModel.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class SearchAlbumAPIModel: Codable {
    
    let topalbums: Topalbum?
    
    enum CodingKeys: String, CodingKey {
        
        case topalbums
    }
    init(topalbums: Topalbum?) {
        
        self.topalbums = topalbums
    }
}
