//
//  Result.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation
import ObjectMapper

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
