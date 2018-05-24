//
//  ViewController.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 14/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    //Scroll View
    @IBOutlet weak var menuScrollView: UIScrollView!
    //Constraints
    @IBOutlet weak var menuCollectionHeightConstraint: NSLayoutConstraint!
    //Collection's
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    //Xtories to collection
    var stories: [Story] = []
    var favoriteStories: [Story] = []
    //Flags
    var firstScroll = true
    ///initial of the controller
    override func viewDidLoad() {
        super.viewDidLoad()

        self.stories = MenuServices.allStories()
        self.favoriteStories = MenuServices.allStories()
        self.collectionView.reloadData()
    }
    ///Before performing a segue this function is called
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

