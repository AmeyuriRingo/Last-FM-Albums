//
//  Image.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

class Image: NSObject, NSCoding, Mappable {
    
    var text: String?
    var size: String?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Image()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        text <- map["#text"]
        size <- map["size"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        text = aDecoder.decodeObject(forKey: "#text") as? String
        size = aDecoder.decodeObject(forKey: "size") as? String
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if text != nil {
            aCoder.encode(text, forKey: "#text")
        }
        if size != nil {
            
            aCoder.encode(size, forKey: "size")
        }
    }
}
