//
//  ViewController.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/1/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class MainScreenViewController: UICollectionViewController {

//    private let reuseIdentifier = "AlbumCell"
//    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBackButton()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func hideBackButton() {
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
    }
}
