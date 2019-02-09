//
//  File.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/6/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    // добавить конфигуратор
    @IBOutlet weak var albumName: UILabel!
    
    override func prepareForReuse() {
        
        albumName.text = nil
    }
}
