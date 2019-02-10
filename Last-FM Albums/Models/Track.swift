//
//  Track.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

class Track: NSObject, NSCoding, Mappable {
    
    var name: String?
    var track: [Track]?
    var duration: String?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Track()
    }
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        name <- map["name"]
        track <- map["track"]
        duration <- map["duration"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObject(forKey: "name") as? String
        track = aDecoder.decodeObject(forKey: "track") as? [Track]
        duration = aDecoder.decodeObject(forKey: "duration") as? String
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if name != nil {
            
            aCoder.encode(name, forKey: "name")
        }
        
        if track != nil {
            
            aCoder.encode(track, forKey: "track")
        }
        
        if duration != nil {
            
            aCoder.encode(duration, forKey: "duration")
        }
    }
}
