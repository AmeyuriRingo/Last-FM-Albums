//
//  DataStructure.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class DataStructure {
    
    var artist: String
    var image: UIImage
    var name: String
    var tracks: String
    
    init(artist: String, image: UIImage, name: String, tracks: String) {
        
        self.artist = artist
        self.image = image
        self.name = name
        self.tracks = tracks
    }
}
