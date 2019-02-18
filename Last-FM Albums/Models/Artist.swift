//
//  Artist.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class Artist: Codable {
    
    let name: String?
    //let image: [Image]?
    
    init(name: String? /*image: [Image]?*/) {
        
        self.name = name
        //self.image = image
    }
}
