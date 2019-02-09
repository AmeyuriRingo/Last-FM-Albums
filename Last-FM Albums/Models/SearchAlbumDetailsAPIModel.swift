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

class Album: NSObject, NSCoding, Mappable {
    
    var artist: String?
    var image: [Image]?
    var name: String?
    var tracks: Track?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Album()
    }
    
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        artist <- map["artist"]
        image <- map["image"]
        name <- map["name"]
        tracks <- map["tracks"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        artist = aDecoder.decodeObject(forKey: "artist") as? String
        image = aDecoder.decodeObject(forKey: "image") as? [Image]
        name = aDecoder.decodeObject(forKey: "name") as? String
        tracks = aDecoder.decodeObject(forKey: "tracks") as? Track
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if artist != nil {
            
            aCoder.encode(artist, forKey: "artist")
        }
        if image != nil {
            
            aCoder.encode(image, forKey: "image")
        }
        if name != nil {
            
            aCoder.encode(name, forKey: "name")
        }
        if tracks != nil {
            
            aCoder.encode(tracks, forKey: "tracks")
        }
    }
}

class Track: NSObject, NSCoding, Mappable {
    
    var name: String?
    var track: [Track]?
    
    class func newInstance(map: Map) -> Mappable? {
        
        return Track()
    }
    required init?(map: Map) {}
    
    private override init() {}
    
    func mapping(map: Map) {
        
        name <- map["name"]
        track <- map["track"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObject(forKey: "name") as? String
        track = aDecoder.decodeObject(forKey: "track") as? [Track]
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if name != nil {
            
            aCoder.encode(name, forKey: "name")
        }
        if track != nil {
            
            aCoder.encode(track, forKey: "track")
        }
    }
}
