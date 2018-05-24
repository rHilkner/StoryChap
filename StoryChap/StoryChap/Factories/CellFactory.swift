//
//  CellFactory.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 14/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

public enum CellType: String {
    case movieCell = "StoryCell"
}

class CellFactory {

    /// Returns story cell for given story
    static func storyCell(collectionView: UICollectionView, indexPath: IndexPath, story: Story) -> StoryCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.movieCell.rawValue, for: indexPath) as! StoryCollectionViewCell

        cell.thumbnailImage.image = UIImage(named: story.thumbnailImageName)

        return cell
    }
    
    /// Returns story cell for given story
    static func favoriteStoryCell(collectionView: UICollectionView, indexPath: IndexPath, story: Story) -> StoryCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.movieCell.rawValue, for: indexPath) as! StoryCollectionViewCell
        
        cell.thumbnailImage.image = UIImage(named: story.thumbnailImageName)
        
        return cell
    }
}
