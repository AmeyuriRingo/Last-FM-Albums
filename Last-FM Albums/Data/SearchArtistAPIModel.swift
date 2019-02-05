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

class Result: NSObject, NSCoding, Mappable {
    
    var artistmatches: Artistmatche?
    var opensearchitemsPerPage: String?
    var opensearchstartIndex: String?
    var opensearchtotalResults: String?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Result()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        artistmatches <- map["artistmatches"]
        opensearchitemsPerPage <- map["opensearch:itemsPerPage"]
        opensearchstartIndex <- map["opensearch:startIndex"]
        opensearchtotalResults <- map["opensearch:totalResults"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        opensearchitemsPerPage = aDecoder.decodeObject(forKey: "opensearch:itemsPerPage") as? String
        opensearchstartIndex = aDecoder.decodeObject(forKey: "opensearch:startIndex") as? String
        opensearchtotalResults = aDecoder.decodeObject(forKey: "opensearch:totalResults") as? String
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if artistmatches != nil {
            
            aCoder.encode(artistmatches, forKey: "artistmatches")
        }
        if opensearchitemsPerPage != nil {
            
            aCoder.encode(opensearchitemsPerPage, forKey: "opensearch:itemsPerPage")
        }
        if opensearchstartIndex != nil {
            
            aCoder.encode(opensearchstartIndex, forKey: "opensearch:startIndex")
        }
        if opensearchtotalResults != nil {
            
            aCoder.encode(opensearchtotalResults, forKey: "opensearch:totalResults")
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
    var listeners: String?
    var mbid: String?
    var name: String?
    var streamable: String?
    var url: String?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Artist()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        image <- map["image"]
        listeners <- map["listeners"]
        mbid <- map["mbid"]
        name <- map["name"]
        streamable <- map["streamable"]
        url <- map["url"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        image = aDecoder.decodeObject(forKey: "image") as? [Image]
        listeners = aDecoder.decodeObject(forKey: "listeners") as? String
        mbid = aDecoder.decodeObject(forKey: "mbid") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        streamable = aDecoder.decodeObject(forKey: "streamable") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if image != nil {
            
            aCoder.encode(image, forKey: "image")
        }
        if listeners != nil {
            
            aCoder.encode(listeners, forKey: "listeners")
        }
        if mbid != nil {
            
            aCoder.encode(mbid, forKey: "mbid")
        }
        if name != nil {
            
            aCoder.encode(name, forKey: "name")
        }
        if streamable != nil {
            
            aCoder.encode(streamable, forKey: "streamable")
        }
        if url != nil {
            
            aCoder.encode(url, forKey: "url")
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
