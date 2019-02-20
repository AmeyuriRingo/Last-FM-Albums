//
//  AlbumName.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class AlbumName: Codable {
    
    let image: [Image]?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        
        case image = "image"
        case name = "name"
    }
    init(image: [Image], name: String?) {
        
        self.image = image
        self.name = name
    }
}
