//
//  SearchStructure.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/2/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchArtistAPIModel: NSObject, NSCoding, Mappable {
    
    var results: Result?
    
    class func newInstance(map: Map) -> Mappable? {
        return SearchArtistAPIModel()
    }
    
    required init?(map: Map) { }
    
    private override init() { }
    
    func mapping(map: Map) {
        
        results <- map["results"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        results = aDecoder.decodeObject(forKey: "results") as? Result
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if results != nil {
            aCoder.encode(results, forKey: "results")
        }
    }
}

class Result: NSObject, Mappable {
    
    var artistmatches: Artistmatche?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Result()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        artistmatches <- map["artistmatches"]
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if artistmatches != nil {
            
            aCoder.encode(artistmatches, forKey: "artistmatches")
        }
    }
}

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
