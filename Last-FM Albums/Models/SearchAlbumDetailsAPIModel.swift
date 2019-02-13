//
//  SearchAlbumDetailsAPIModel.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchAlbumDetailsAPIModel: NSObject, NSCoding, Mappable {
    
    var album: Album?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return SearchAlbumDetailsAPIModel()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        album <- map["album"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        album = aDecoder.decodeObject(forKey: "album") as? Album
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if album != nil {
            
            aCoder.encode(album, forKey: "album")
        }
    }
}
