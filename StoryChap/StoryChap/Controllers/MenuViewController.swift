//
//  ViewController.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 14/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

//Constants with restoration ids from storyboard
private struct RestorationIds {
    static let favoriteCollection = "favoriteCollection"
    static let menuCollection = "menuCollection"
}

class MenuViewController: UIViewController {

    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    var stories: [Story] = []
    var favoriteStories: [Story] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        self.stories = MenuServices.allStories()
        self.favoriteStories = MenuServices.allStories()
        self.collectionView.reloadData()
    }

}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIds.storyDetails.rawValue, sender: self.stories[0])
    }
}

extension MenuViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.restorationIdentifier {
        case RestorationIds.favoriteCollection:
            return 4
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

// Dealing with segues
extension MenuViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {

        case SegueIds.storyDetails.rawValue:
            guard let story = sender as? Story else {
                print("-> WARNING: Story sender is nil")
                return
            }

            guard let segueDestination = segue.destination as? StoryDetailsViewController else {
                print("-> WARNING: Segue destination is incorrect")
                return
            }

            // Setting story of next view controller
            segueDestination.story = story

        default:
            break
        }
    }
}

