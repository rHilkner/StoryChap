//
//  StoryDetailsViewController.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 15/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

class StoryDetailsViewController: UIViewController {

    var story: Story?

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var storyDescription: UILabel!
    @IBOutlet weak var playButton: UIButton!

    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [self.playButton]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Verifying if story is not nil
        guard let story = self.story else {
            self.dismiss(animated: true, completion: nil)
            return
        }

        self.setNeedsFocusUpdate()
    }

    @IBAction func playButtonPressed() {
        let game = Game(id: "abc", story: self.story!, currentEvent: nil, numberOfPlayers: 1, characters: [])

        performSegue(withIdentifier: SegueIds.game.rawValue, sender: game)
    }
}

// Dealing with segues
extension StoryDetailsViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        switch segue.identifier {
        case SegueIds.game.rawValue:
            guard let game = sender as? Game else {
                print("-> WARNING: Story sender is nil")
                return
            }

            guard let segueDestination = segue.destination as? GameViewController else {
                print("-> WARNING: Segue destination is incorrect")
                return
            }

            // Setting story of game view controller
            segueDestination.game = game

        default:
            break
        }
    }
}
