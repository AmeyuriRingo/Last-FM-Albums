//
//  Artistmatche.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

class Artistmatche: NSObject, NSCoding, Mappable {
    
    var artist: [Artist]?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Artistmatche()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        artist <- map["artist"]
        
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        artist = aDecoder.decodeObject(forKey: "artist") as? [Artist]
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if artist != nil {
            
            aCoder.encode(artist, forKey: "artist")
        }
    }
}
