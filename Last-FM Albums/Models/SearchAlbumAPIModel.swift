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

class AlbumName: NSObject, NSCoding, Mappable {
    
    var image: [AlbumImage]?
    var name: String?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return AlbumName()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        image <- map["image"]
        name <- map["name"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        image = aDecoder.decodeObject(forKey: "image") as? [AlbumImage]
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

class AlbumImage: NSObject, NSCoding, Mappable {

    var text: String?
    var size: String?

    class func newInstance(map: Map) -> Mappable? {
        
        return AlbumImage()
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
