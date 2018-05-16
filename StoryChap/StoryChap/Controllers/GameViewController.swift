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
    @IBOutlet weak var textLabel: UILabel!

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
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.select.rawValue)]
        self.view.addGestureRecognizer(tapRecognizer)

        // Setting game current event as story initial event
        let initialEvent = self.game?.story.initialEvent
        self.game?.currentEvent = initialEvent

        // Getting current scene as first scene of current event
        guard let currentScene = self.game?.currentEvent?.scenes[0] else {
            print("-> WARNING: Initial scene returned nil")
            return
        }

        // Setting up background image and text label
        self.backgroundImage.image = currentScene.image
        self.textLabel.text = currentScene.text
    }

    /// Function called when "select" tap gesture occures
    @objc func tapped() {
        guard let eventScenes = self.game?.currentEvent?.scenes else {
            print("-> WARNING: Event scenes found nil")
            return
        }

        // For every scene (except last), when clicked, show next scene
        if self.currentSceneIndex < eventScenes.endIndex-1 {
            self.currentSceneIndex += 1

            let currentScene = eventScenes[self.currentSceneIndex]

            self.backgroundImage.image = currentScene.image
            self.textLabel.text = currentScene.text

        }

        // If scene after click is the last, then show options to the user. In case there's no options, then show "end game" button.
        if self.currentSceneIndex == eventScenes.endIndex-1 {
            self.currentSceneIndex += 1

            // TODO: mostrar opções (como mostrar conjunto de botões para cada próximo evento possivel (button[i].title = nextPossibleEvents[i].optionsText) e esperar seleção do usuario??)
            // No momento em que o usuário selecionar o botão desejado, modificar self.game?.currentEvent para o evento selecionado, além dos UIComponents desta classe (background a text) para a primeira scena do novo evento
        }
    }

}
