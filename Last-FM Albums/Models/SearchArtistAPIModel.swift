//
//  SearchStructure.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/2/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class SearchArtistAPIModel: Codable {
    
    let results: SearchResults?
    
    init(results: SearchResults?) {
        
        self.results = results
    }
}
