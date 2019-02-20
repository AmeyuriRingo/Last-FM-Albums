//
//  AlbumImage.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class AlbumImage: Codable {
    
    let text: String?
    let size: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size = "size"
    }
    init(text: String?, size: String?) {
        
        self.text = text
        self.size = size
    }    
}
