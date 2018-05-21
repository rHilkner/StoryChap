//
//  GameViewController.swift
//  StoryChap
//
//  Created by Rodrigo Hilkner on 16/05/18.
//  Copyright © 2018 Rodrigo Hilkner. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var game: Game?
    var currentSceneIndex: Int = 0
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var textView: UITextView!

    // Buttons of the choices the user may take
    @IBOutlet weak var option0Button: UIButton!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    var choicesButtons: [UIButton] = []
    @IBOutlet weak var endGameButton: UIButton!

    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        if self.option0Button.isEnabled {
            return [self.option0Button]
        } else if self.endGameButton.isEnabled {
            return [self.endGameButton]
        }

        return []
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Verifying if story is not nil
        guard self.game != nil else {
            print("-> WARNING: Somehow game object is nil on game view controller")
            self.dismiss(animated: true, completion: nil)
            return
        }

        self.initializeUIComponents()
    }

    /// Sets up game current event as story initial event, and also sets up background image and text label for current event scene
    func initializeUIComponents() {

        // Adding tap gesture recognizer
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectButtonTapped))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.select.rawValue)]
        self.view.addGestureRecognizer(tapRecognizer)

        // Initializing array of choices buttons
        self.choicesButtons = [self.option0Button,
                               self.option1Button,
                               self.option2Button,
                               self.option3Button]
        for i in 0..<self.choicesButtons.count {
            self.choicesButtons[i].isHidden = true
            self.choicesButtons[i].isEnabled = false
            self.choicesButtons[i].setTitle("", for: .normal)
            self.choicesButtons[i].tag = i
            self.choicesButtons[i].addTarget(self, action: #selector(choiceMade), for: .primaryActionTriggered)
        }

        // Hiding end game button
        self.endGameButton.isHidden = true
        self.endGameButton.isEnabled = false

        // Setting game current event as initial event
        guard let initialEvent = self.game?.story.initialEvent else {
            print("-> WARNING: Game object returned nil")
            return
        }

        self.setGame(for: initialEvent)
    }


    // When end game button is pressed return to last view controller on hierarchy
    @IBAction func endGameButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

// Handling buttons for choices and end game.
extension GameViewController {

    /// Function called when "select" tap gesture occures
    @objc func selectButtonTapped() {
        guard let eventScenes = self.game?.currentEvent?.scenes else {
            print("-> WARNING: Event scenes found nil")
            return
        }

        // For every scene, when clicked, show next scene
        if self.currentSceneIndex < eventScenes.endIndex-1 {
            self.currentSceneIndex += 1

            let currentScene = eventScenes[self.currentSceneIndex]
            if let currentImageForScene = currentScene.imageName {
                self.backgroundImage.image = UIImage(named: currentImageForScene)
            }
            
            
            self.textView.text = currentScene.text

        }

        // If user clicks on last scene, then show options of choices for next events to the user.
        // In case there's no options, then show "end game" button.
        else if self.currentSceneIndex == eventScenes.endIndex-1 {
            self.currentSceneIndex += 1
            
            // If there are no next possible events to chose, then the game is over
            guard let nextPossibleEvents = self.game?.currentEvent?.nextPossibleEvents else {
                self.displayEndGameButton()
                return
            }

            // Display a set of buttons representing every possible choice the user may take
            self.displayChoicesButtons(choices: nextPossibleEvents)
        }
    }

    /// Displays a set of buttons representing every possible choice the user may take to go to a next event
    func displayChoicesButtons(choices: [Event]) {

        self.textView.text = ""

        // For each choice, display it as a button
        for i in 0..<choices.count {
            self.choicesButtons[i].setTitle(choices[i].optionText, for: .normal)
            self.choicesButtons[i].isHidden = false
            self.choicesButtons[i].isEnabled = true
        }

        self.setNeedsFocusUpdate()
    }

    /// Function called when a choice for next event is selected by the user
    @objc func choiceMade(sender: UIButton) {
        let choiceIndex = sender.tag

        guard let nextEvent = self.game?.currentEvent?.nextPossibleEvents![choiceIndex] else {
            print("-> WARNING: Unexpectedly, the game object, or the current event, or nextPossibleEvents[] returned nil.")
            return
        }

        self.setGame(for: nextEvent)
    }

    /// Displays button with "End Game" text
    func displayEndGameButton() {
        self.backgroundImage = nil
        self.textView.text = "Well played!"
        self.endGameButton.isHidden = false
        self.endGameButton.isEnabled = true
        self.setNeedsFocusUpdate()
    }
}

// Reseting game event after user makes a choice
extension GameViewController {

    /// Updates game current event for event given as argument
    func setGame(for event: Event) {

        self.currentSceneIndex = 0

        // Hiding buttons of choices
        for i in 0..<self.choicesButtons.count {
            self.choicesButtons[i].isHidden = true
            self.choicesButtons[i].isEnabled = false
        }

        // Setting game current event
        self.game?.currentEvent = event

        // Getting initial scene of the event
        guard let initialScene = self.game?.currentEvent?.scenes[0] else {
            print("-> WARNING: Initial scene returned nil")
            return
        }

        // Setting up background image and text label
        if let initialImage = initialScene.imageName {
            self.backgroundImage.image = UIImage(named: initialImage)
        }
        
        self.textView.text = initialScene.text
    }
}
