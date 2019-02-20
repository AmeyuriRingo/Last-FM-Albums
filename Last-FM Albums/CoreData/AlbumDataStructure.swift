//
//  AlbumDataStructure
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class AlbumDataStructure {
    
    var artist: String
    var image: UIImage
    var name: String
    
    init(artist: String, image: UIImage, name: String) {
        
        self.artist = artist
        self.image = image
        self.name = name
    }
}
