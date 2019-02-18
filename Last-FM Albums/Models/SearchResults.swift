//
//  SearchResults
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/10/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import Foundation

class SearchResults: Codable {
    
    let artistMatches: ArtistMatches?
    
    enum CodingKeys: String, CodingKey {
        
        case artistMatches = "artistmatches"
    }
    
    init(artistMatches: ArtistMatches?) {
        
        self.artistMatches = artistMatches
    }
}
