//
//  Topalbum.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

class Topalbum: NSObject, NSCoding, Mappable {
    
    var album: [AlbumName]?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Topalbum()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        album <- map["album"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        album = aDecoder.decodeObject(forKey: "album") as? [AlbumName]
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if album != nil {
            aCoder.encode(album, forKey: "album")
        }
    }
}
