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
