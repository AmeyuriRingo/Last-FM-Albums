//
//  MainScreenViewController.swift
//  Last-FM Albums
//
//  Created by Ringo_02 on 2/1/19.
//  Copyright © 2019 Ringo_02. All rights reserved.
//

import UIKit

class MainScreenViewController: UICollectionViewController {
    
    private var saveData = SaveData()
    private var collectionData: [AlbumDataStructure] = []
    private let reuseIdentifier = "albumCell"
    private let detailSegueIdentifier = "showDetailSegue"
    private let destinationVC = "DetailViewController"
    
    @IBOutlet var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideBackButton()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setDataToVC()
    }
    func setDataToVC() {
        //fetching stored data to collectionView
        collectionData = saveData.fetchDataFromAlbumsDB()
        collection?.reloadData()
    }
    
    func hideBackButton() {
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
}

extension MainScreenViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? StoredALbumsCell else { return UICollectionViewCell()}
        //setting stored data to CollectionView
        cell.storedAlbumImage.image = collectionData[indexPath.row].image
        cell.storedAlbumName.text = collectionData[indexPath.row].name
        cell.storedAlbumArtist.text = collectionData[indexPath.row].artist
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let destination = storyboard?.instantiateViewController(withIdentifier: destinationVC) as? DetailViewController {
            destination.albumsName = collectionData[indexPath.row].name
            destination.artistsName = collectionData[indexPath.row].artist
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
}
