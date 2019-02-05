//
//  ArtistCell.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/5/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {
    
    @IBOutlet weak var artistName: UILabel!
    
    override func prepareForReuse() {
        
        artistName.text = nil
    }
}
