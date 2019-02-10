//
//  SearchAlbumAPIModel.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchAlbumAPIModel: NSObject, NSCoding, Mappable {
    
    var topalbums: Topalbum?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return SearchAlbumAPIModel()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        topalbums <- map["topalbums"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        topalbums = aDecoder.decodeObject(forKey: "topalbums") as? Topalbum
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if topalbums != nil {
            
            aCoder.encode(topalbums, forKey: "topalbums")
        }
    }
}






