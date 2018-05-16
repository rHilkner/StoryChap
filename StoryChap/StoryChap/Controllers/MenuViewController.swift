//
//  ViewController.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 14/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var stories: [Story] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.stories = MenuServices.allStories()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
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

        return self.stories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CellFactory.storyCell(collectionView: collectionView, indexPath: indexPath, story: self.stories[0])

        return cell
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

