//
//  Track.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class Track: Codable {
    
    let duration: String?
    let name: String?
    let track: [Track]?
    
    enum CodingKeys: String, CodingKey {
        case duration = "duration"
        case name = "name"
        case track = "track"
    }
    init(duration: String?, name: String?, track: [Track]?) {
        
        self.duration = duration
        self.name = name
        self.track = track
    }
}
