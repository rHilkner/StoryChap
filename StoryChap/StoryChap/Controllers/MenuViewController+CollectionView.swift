//
//  MenuViewController+CollectionView.swift
//  StoryChap
//
//  Created by Rhullian Damião on 22/05/2018.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit


//Constants with restoration ids from storyboard
private struct RestorationIds {
    static let favoriteCollection = "favoriteCollection"
    static let menuCollection = "menuCollection"
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    /// MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIds.storyDetails.rawValue, sender: self.stories[0])
    }
    
    /// MARK: DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case RestorationIds.favoriteCollection:
            return 1
        case RestorationIds.menuCollection:
            return 20
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier {
        case RestorationIds.favoriteCollection:
            return CellFactory.favoriteStoryCell(collectionView: collectionView, indexPath: indexPath, story: stories[0])
        case RestorationIds.menuCollection:
            return CellFactory.storyCell(collectionView: collectionView, indexPath: indexPath, story: stories[0])
        default:
            return UICollectionViewCell()
        }
    }
}
