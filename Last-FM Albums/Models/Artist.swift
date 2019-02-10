//
//  Artist.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

class Artist: NSObject, NSCoding, Mappable {
    
    var image: [Image]?
    var name: String?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Artist()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        image <- map["image"]
        name <- map["name"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        image = aDecoder.decodeObject(forKey: "image") as? [Image]
        name = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if image != nil {
            
            aCoder.encode(image, forKey: "image")
        }
        if name != nil {
            
            aCoder.encode(name, forKey: "name")
        }
    }
}
